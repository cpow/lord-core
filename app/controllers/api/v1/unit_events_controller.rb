module Api::V1
  class UnitEventsController < ApplicationController
    before_action :authenticate_user!

    def index
      unit = Unit.find(params[:unit_id])

      @events = unit
                .notifications
                .includes(:event_reads)
                .order(created_at: :desc)
                .limit(20)
                .page(params[:page])
                .per(5)

      @current_user = current_user || current_property_manager

      render :index, status: :ok
    end

    private

    def event_params
      params.require(:event).permit(:readble_id, :readable_type, :id)
    end
  end
end

