module Api
  module V1
    class LineItemsController < ApplicationController
      before_action :authenticate_property_manager!

      def index
        @line_items = LineItem.search(
          '*',
          where: {
            comany_id: current_property_manager.company.id
          },
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
    end
  end
end
