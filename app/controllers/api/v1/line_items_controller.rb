module Api
  module V1
    class LineItemsController < ApplicationController
      before_action :authenticate_property_manager!

      def index
        @line_items = LineItems::Query.new(
          params: params, company: company
        ).search

        render :index, status: :ok
      end

      private

      def company
        @company ||= current_property_manager.company
      end
    end
  end
end
