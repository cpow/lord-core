class ExpensesController < ApplicationController
  before_action :authenticate_property_manager!

  def new
    @expense = Expense.new(expense_params)
    @expenseable_objects = expenseable_objects
  end

  def create
    @expense = Expense.new(expense_params)
    if @expense.save
      LineItem.create!(itemable: @expense, company: @expense.company)
      flash[:success] = 'Successfully created expense!'
      redirect_to expenses_path
    else
      render :new
    end
  end

  def index
    @expenses = current_property_manager.company.expenses
  end

  private

  def expenseable_objects
    case @expense.expenseable_type
    when 'Property'
      current_property_manager.company.properties.map { |p| [p.name, p.id] }
    when 'Unit'
      current_property_manager.company.units.map { |u| [u.name, u.id] }
    when 'Issue'
      current_property_manager.company.issues.map do |u|
        ["##{u.id}, #{u.category}", u.id]
      end
    else
      []
    end
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
