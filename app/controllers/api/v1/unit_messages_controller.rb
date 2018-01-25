module Api::V1
  class UnitMessagesController < ApplicationController
    def show
      @message = Message.find(params[:id])
      render :show, status: :ok
    end

    def index
      unit = Unit.find(params[:unit_id])
      @messages = unit.messages.limit(200)
      render :index, status: :ok
    end
  end
end
