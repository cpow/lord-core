class Users::IssuesController < ApplicationController
  before_action :authenticate_user!

  def index
    @issues = Issue.where(reporter: current_user)
  end

  def show
    @issue = Issue.where(reporter: current_user, id: params[:id]).first
  end
end
