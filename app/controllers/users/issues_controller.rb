class Users::IssuesController < ApplicationController
  before_action :authenticate_user!

  def index
    @issues = Issue.where(reporter: current_user)
  end
end
