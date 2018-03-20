module Api::V1
  class PropertyEventsController < ApplicationController
    def update
      @event = Event.find(params[:id])
      @event.update_attributes!(event_params)
      render '', status: :ok
    end

    def index
      property = Property.find(params[:property_id])
      @events = property.notifications.order(:created_at).limit(100)
      render :index, status: :ok
    end

    private

    def event_params
      params.require(:event).permit(:read, :id)
    end
  end
end
