require 'rails_helper'

describe Api::V1::Stripe::Webhooks::ChargesController do
  describe '#create' do
    context 'when there is a payment that matches the charge id' do
      it 'should create a charge event' do
        payment = create(:payment)
        params = valid_stripe_webhook_params(
          id: payment.stripe_charge_id,
          type: 'charge.pending'
        )
        allow(Stripe::Webhook).to receive(:construct_event) { true }

        expect do
          post :create, params: params
        end.to change(ChargeEvent, :count).by(1)

        expect(payment.reload.latest_event_type).to eq(params[:type])
      end
    end
  end

  def valid_stripe_webhook_params(id:, type:)
    {
      type: type,
      object: 'event',
      request: nil,
      pending_webhooks: 1,
      api_version: '2017-12-14',
      data: {
        object: {
          failure_code: 'something',
          failuire_message: 'some failure message',
          id: id
        }
      }
    }
  end
end
