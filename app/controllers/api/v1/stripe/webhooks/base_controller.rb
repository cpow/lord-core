module Api::V1::Stripe::Webhooks
  class BaseController < ApplicationController
    def verify_request
      payload = request.body.read
      sig_header = request.env['HTTP_STRIPE_SIGNATURE']
      endpoint_secret = ENV['WEBHOOK_SECRET']

      begin
        Stripe::Webhook.construct_event(
          payload, sig_header, endpoint_secret
        )
      rescue JSON::ParserError => e
        render json: {'error': e}, status: 400
        return
      rescue Stripe::SignatureVerificationError => e
        render json: {'error': e}, status: 400
        return
      end
    end
  end
end
