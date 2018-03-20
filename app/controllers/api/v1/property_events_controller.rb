module Api::V1
  class PropertyEventsController < ApplicationController
    def index
      property = Property.find(params[:property_id])
      @events = property.notifications.order(:created_at).limit(100)
      render :index, status: :ok
    end
  end
end
