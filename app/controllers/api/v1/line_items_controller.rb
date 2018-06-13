module Api
  module V1
    class LineItemsController < ApplicationController
      before_action :authenticate_property_manager!

      def index
        @line_items = LineItem.search(
          '*',
          where: filter_params,
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

      def filter_params
        base = {
          company_id: company.id
        }

        if params[:itemable_type].present?
          base[:itemable_type] = params[:itemable_type]
        end

        if params[:start_date].present? && params[:end_date].present?
          base[:created_on] = \
            { gte: params[:start_date], lte: params[:end_date] }
        end

        base
      end
    end
  end
end
