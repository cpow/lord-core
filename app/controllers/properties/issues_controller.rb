class Properties::IssuesController < ApplicationController
  before_action :authenticate_property_manager!
  before_action :set_property
  before_action :set_issue, only: [:show, :edit, :update]
  before_action :set_company

  def show
  end

  def edit
  end

  def update
    @issue.assign_attributes(issue_params)
    if @issue.valid?
      IssueComment.create!(
        issue: @issue,
        commentable: current_property_manager,
        body: "Issue Updated: #{@issue.changes}"
      )
    end

    if @issue.save
      redirect_to property_issue_path(@issue.property, @issue),
        notice: 'Successfully updated issue!'
    else
      render action: :edit, notice: 'There were errors updating your issue.'
    end
  end

  private

  def issue_params
    params.require(:issue).permit(:status, :category)
  end

  def set_issue
    @issue = Issue.find(params[:id])
  end
end
