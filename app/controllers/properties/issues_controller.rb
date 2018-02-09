class Properties::IssuesController < ApplicationController
  before_action :authenticate_property_manager!
  before_action :set_property
  before_action :set_issue, only: [:show, :edit]
  before_action :set_company

  def show
  end

  private

  def set_issue
    @issue = Issue.find(params[:id])
  end
end
