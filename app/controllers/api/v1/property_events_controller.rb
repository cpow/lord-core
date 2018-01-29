module Api::V1
  class PropertyEventsController < ApplicationController
    def index
      @property = Property.includes(:events,
                                    :property_images,
                                    units: [{messages: :events}, :events],
                                    residencies: :events)
        .find(params[:property_id])

      @messages = @property.units.map(&:messages)

      @events = Event.where(
        eventable: [@property.units,
                    @property.residencies,
                    @messages,
                    @property].flatten)

      render :index, status: :ok
    end
  end
end
