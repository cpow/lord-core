module Api
  module V1
    class LineItemsController < ApplicationController
      before_action :authenticate_property_manager!


      def index
        @line_items = LineItem.search(
          '*',
          where: filter_params(filter_keys, initial_object),
          page: params[:page],
          per_page: 10,
          order: {
            created_at: {
              order: 'desc'
            }
          }
        )

        render :index, status: :ok
      end

      private

      def company
        @company ||= current_property_manager.company
      end

      def filter_keys
        %i[itemable_type]
      end

      def initial_object
        { company_id: company.id }
      end
    end
  end
end
