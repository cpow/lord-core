class CompaniesController < ApplicationController
  before_action :authenticate_property_manager!

  def new
    @company = Company.new
  end

  def edit
    @company = Company.find(params[:id])
  end

  def update
    @company = Company.find(params[:id])

    if @company.update_attributes(company_params)
      redirect_to @company, notice: 'Company was successfully created.'
    else
      render action: :edit, notice: 'There were errors creating your company.'
    end
  end

  def create
    @company = Company.new(company_params)

    if @company.save
      current_property_manager.update_attributes!(company: @company)
      redirect_to @company, notice: 'Company was successfully created.'
    else
      render action: :new, notice: 'There were errors creating your company.'
    end
  end

  private

  def company_params
    params.require(:company).permit(:name)
  end
end
