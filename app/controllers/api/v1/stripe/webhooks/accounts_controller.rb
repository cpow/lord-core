module Api::V1::Stripe::Webhooks
  class AccountsController < BaseController
    skip_before_action :verify_authenticity_token
    before_action :company_from_stripe_account
    before_action :verify_request

    def create
      if @company_from_stripe_account
        if verification_needed?
          @company_from_stripe_account.update(stripe_problem: true)
        end
      end

      render json: 'THANKS', status: :ok
    end

    private

    def company_from_stripe_account
      @company_from_stripe_account ||= \
        Company.find_by(stripe_account_guid: account_id)
    end

    def account_id
      @account_id ||= params[:data][:object][:id]
    end

    def verification_needed?
      params[:data][:object][:verification][:fields_needed].present?
    end

    def event_type
      @event_type ||= params[:type]
    end
  end
end

