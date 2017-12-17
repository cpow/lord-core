class UserDashboardController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
    @lease_payment = current_user.current_lease_payment
    @property = current_user.properties.last
  end
end
