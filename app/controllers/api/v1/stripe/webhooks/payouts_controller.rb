module Api::V1::Stripe::Webhooks
  class PayoutsController < ApplicationController
    skip_before_action :verify_authenticity_token
  end
end
