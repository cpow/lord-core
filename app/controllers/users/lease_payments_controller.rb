class Users::LeasePaymentsController < ApplicationController
  before_action :authenticate_user!

  def show
    @lease_payment = current_user.current_unit.lease_payments.find(params[:id])
  end
end
