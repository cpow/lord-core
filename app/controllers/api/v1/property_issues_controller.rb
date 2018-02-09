module Api::V1
  class PropertyIssuesController < ApplicationController
    before_action :authenticate_property_manager!
    before_action :property

    def index
      @issues = property.issues.eager_load(:unit, :issue_images, :issue_comments)
      render :index, status: :ok
    end

    private

    def property
      @property ||= Property.find(params[:property_id])
    end
  end
end
