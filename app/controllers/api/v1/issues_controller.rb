module Api::V1
  class IssuesController < ApplicationController
    before_action :authenticate_user!

    def create
      issue = Issue.create!(issue_params_with_user)
      issue.issue_images.create!(issue_image_params)
      Event.create(eventable: issue,
                  createable: current_user,
                  event_type: Event::EVENT_CREATED)
    end

    private

    def issue_params_with_user
      issue_params.merge(
        reporter: current_user,
        unit: current_user.current_unit,
        property: current_user.current_unit.property
      )
    end

    def issue_params
      params.require(:issue).permit(:category, :description)
    end

    def issue_image_params
      params.require(:issue).permit(:image, :image_file_name)
    end
  end
end
