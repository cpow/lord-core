class LineItemsController < ApplicationController
  before_action :authenticate_property_manager!
  before_action :company

  def index
    @line_items = LineItems::Query.new(
      params: params, company: company
    ).search

    respond_to do |format|
      format.html
      format.csv do
        send_data Generators::Csv::LineItems.new(@line_items).generate
      end
    end
  end

  private

  def company
    @company ||= current_property_manager.company
  end
end
