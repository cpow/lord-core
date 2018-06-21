class Companies::PropertyManagersController < ApplicationController
  before_action :authenticate_property_manager!
  before_action :can_manage_company!
  before_action :company

  def show
    @property_manager = company.property_managers.find(params[:id])
  end

  private

  def company
    @company ||= Company.find(params[:company_id])
  end
end
