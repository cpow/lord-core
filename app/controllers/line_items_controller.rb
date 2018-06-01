class LineItemsController < ApplicationController
  before_action :authenticate_property_manager!

  def index
    @line_items = current_property_manager.company.line_items
  end
end
