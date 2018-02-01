module Api::V1
  class ResidenciesController < ApplicationController
    before_action :authenticate_property_manager!

    def index
      @residencies = current_property_manager
                     .company
                     .residencies
                     .eager_load(:user, :unit)
      render :index, status: :ok
    end
  end
end

