class MessagesController < ApplicationController
  def index
    @unit = Unit.find(params[:unit_id])
  end
end
