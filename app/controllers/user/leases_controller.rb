class User::LeasesController < ApplicationController
  before_action :authenticate_user!

  def show
    @lease = Lease.find(params[:id])
  end
end
