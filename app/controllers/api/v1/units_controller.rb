module Api::V1
  class UnitsController < ApplicationController
    before_action :authenticate_property_manager!

    def index
      @units = current_company.units.eager_load(:lease_payments, :leases)
      render :index, status: :ok
    end
  end
end

