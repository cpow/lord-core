module Api::V1::Stripe::Webhooks
  class PayoutsController < ApplicationController
    protect_from_forgery except: :create
  end
end
