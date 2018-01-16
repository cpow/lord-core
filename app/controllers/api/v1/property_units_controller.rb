module Api::V1
  class PropertyUnitsController < ApplicationController
    before_action :authenticate_property_manager!
    before_action :get_property

    def index
      @units = @property.units.eager_load(:lease_payments, :leases)
      render :index, status: :ok
    end

    private

    def get_property
      @property = Property.find(params[:property_id])
    end
  end
end
