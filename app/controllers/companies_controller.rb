class CompaniesController < ApplicationController
  before_action :authenticate_property_manager!
  before_action :can_create_company, only: %i[new create]

  def new
    @company = Company.new
  end

  def edit
    @company = Company.find(params[:id])
  end

  def show
    @company = Company.find(params[:id])
  end

  def update
    @company = Company.find(params[:id])

    if @company.update_attributes(company_params)
      redirect_to @company, notice: 'Company was successfully updated.'
    else
      render action: :edit, notice: 'There were errors updating your company.'
    end
  end

  def create
    @company = Company.new(company_params)

    if @company.save
      current_property_manager.make_admin_with_company(@company)
      redirect_to @company, notice: 'Company was successfully created.'
    else
      render action: :new, notice: 'There were errors creating your company.'
    end
  end

  private

  def can_create_company
    if current_property_manager.has_company?
      flash[:error] = 'You already have a company, you cannot create another'
      redirect_to page_path('property_manager_home')
    end
  end

  def company_params
    params.require(:company).permit(:name)
  end
end
