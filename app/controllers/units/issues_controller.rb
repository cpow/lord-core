class Units::IssuesController < ApplicationController
  before_action :authenticate_user!

  def index
    @issues = Issue.where(unit: current_user.current_unit)
  end

  def show
    @issue = Issue.find_by(
      unit: current_user.current_unit, id: params[:id]
    )
  end
end
