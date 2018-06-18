module Api::V1::Stripe::Webhooks
  class ChargesController < BaseController
    skip_before_action :verify_authenticity_token
    before_action :payment_from_stripe
    before_action :verify_request

    def create
      if @payment_from_stripe
        @payment_from_stripe.update(latest_event_type: event_type)
        ChargeEvent.create!(create_params)
      end

      render json: 'THANKS', status: :ok
    end

    private

    def payment_from_stripe
      @payment_from_stripe ||= Payment.find_by(stripe_charge_id: charge_id)
    end

    def create_params
      {
        payment: @payment_from_stripe,
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
