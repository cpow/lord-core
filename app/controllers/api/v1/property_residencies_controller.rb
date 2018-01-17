module Api::V1
  class PropertyResidenciesController < ApplicationController
    before_action :authenticate_property_manager!
    before_action :property

    def index
      @residencies = property.residencies.eager_load(:user, :unit)
      render :index, status: :ok
    end

    private

    def property
      @property ||= Property.find(params[:property_id])
    end
  end
end
