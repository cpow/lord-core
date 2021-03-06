module Api::V1
  class PropertyEventsController < ApplicationController
    before_action :authenticate_property_manager!

    def index
      property = Property.find(params[:property_id])

      @events = property
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
