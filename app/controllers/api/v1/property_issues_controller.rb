module Api::V1
  class PropertyIssuesController < ApplicationController
    before_action :authenticate_property_manager!
    before_action :property

    def index
      @issues = property
                .issues
                .eager_load(:unit, :issue_images, :issue_comments)
                .search(unit_search,
                        fields: [:unit_name],
                        where: filter_params,
                        page: params[:page],
                        per_page: 10,
                        order: {
                          created_at: {order: 'desc'},
                          status: {order: 'desc'}
                        }
                       )

      render :index, status: :ok
    end

    private

    def property
      @property ||= Property.find(params[:property_id])
    end

    def filter_params
      [:category, :status].inject({}) do |obj, param_key|
        if params[param_key].present?
          obj.merge!(Hash[param_key, params[param_key]])
        end
        obj
      end
    end

    def unit_search
      params[:unitSearch].present? ? params[:unitSearch] : '*'
    end
  end
end
