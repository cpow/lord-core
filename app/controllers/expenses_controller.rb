class ExpensesController < ApplicationController
  before_action :authenticate_property_manager!
  before_action :company

  def new
    @edit_or_new_url = new_expense_path
    @back_url = new_expense_path
    @expense = @company.expenses.new(expense_params)
    @expenseable_objects = expenseable_objects
  end

  def create
    @expense = @company.expenses.new(expense_params)
    if @expense.save
      @expense.update(amount: @expense.amount * 100)
      LineItem.create!(itemable: @expense, company: @expense.company)
      flash[:success] = 'Successfully created expense!'
      redirect_to line_items_path
    else
      render :new
    end
  end

  def index
    @expenses = @company.expenses
  end

  def show
    @expense = @company.expenses.find(params[:id])
  end

  def edit
    @expense ||= company.expenses.find(params[:id])
    @edit_or_new_url = edit_expense_path(@expense)
    @expenseable_objects = expenseable_objects
    @back_url = changing_expenseable_type_expense_path(@expense)
  end

  def changing_expenseable_type
    @expense = company.expenses.find_by(id: params[:id])
    if @expense
      @expense.changing_expenseable_type = true
      @edit_or_new_url = update_expenseable_type_expense_path(@expense)
      render :edit
    else
      render :new
    end
  end

  def update_expenseable_type
    @expense = company.expenses.find(params[:id])
    @back_url = changing_expenseable_type_expense_path(@expense)
    @expense.changing_expenseable_type = false
    @expense.expenseable_type = expense_params[:expenseable_type]
    @expenseable_objects = expenseable_objects
    render :edit
  end

  def update
    @expense = company.expenses.find(params[:id])
    @expense.assign_attributes(expense_params)

    if @expense.valid?
      @expense.amount = @expense.amount * 100 if @expense.amount_changed?
      @expense.save
      flash[:success] = 'Successfully updated expense!'
      redirect_to line_items_path
    else
      render :edit
    end
  end

  private

  def expenseable_objects
    case @expense.expenseable_type
    when 'Property'
      @company.properties.map { |p| [p.name, p.id] }
    when 'Unit'
      @company.units.map { |u| [u.name, u.id] }
    when 'Issue'
      @company.issues.map do |u|
        ["##{u.id}, #{u.category}", u.id]
      end
    else
      []
    end
  end

  def company
    @company ||= current_property_manager.company
  end

  def expense_params
    if params[:expense]
      params.require(:expense).permit(
        :expenseable_type,
        :expenseable_id,
        :description,
        :company_id,
        :amount
      )
    end
  end
end
