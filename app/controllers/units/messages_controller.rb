class Units::MessagesController < ApplicationController
  def index
    @unit = Unit.find(params[:unit_id])
    @property = @unit.property
    @company = @property.company
  end
end

