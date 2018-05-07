module Api::V1::Stripe::Webhooks
  class ChargesController < ApplicationController
    skip_before_action :verify_authenticity_token
    before_action :payment_from_stripe

    def create
      if @payment
        @payment.update(latest_event_type: event_type)
        ChargeEvent.create!(create_params)
      end

      render json: 'THANKS', status: :ok
    end

    private

    def payment_from_stripe
      @payment ||= Payment.find_by(stripe_charge_id: charge_id)
    end

    def create_params
      {
        payment: @payment,
        stripe_charge_id: charge_id,
        event_type: event_type
      }.merge(failure_data)
    end

    def failure_data
      {
        failure_code: params[:data][:failure_code],
        failure_message: params[:data][:failure_message]
      }
    end

    def charge_id
      @charge_id ||= params[:data][:object][:id]
    end

    def event_type
      @event_type ||= params[:type]
    end
  end
end
