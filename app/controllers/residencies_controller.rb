class ResidenciesController < ApplicationController
  before_action :authenticate_property_manager!
  before_action :set_company

  def index
    @residencies = @company.residencies
  end
end
