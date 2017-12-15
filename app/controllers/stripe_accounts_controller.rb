class StripeAccountsController < ApplicationController
  before_action :authenticate_property_manager!
  before_action :can_manage_company!

  def new
    @account = StripeAccount.new
  end

  def create
    @account = StripeAccount.new(account_params)

    if @account.save
      begin
        stripe_account = Stripe::Account.create(
          type: 'custom',
          legal_entity: {
            first_name: account_params[:first_name].capitalize,
            last_name: account_params[:last_name].capitalize,
            type: account_params[:account_type],
            dob: {
              day: account_params[:dob_day],
              month: account_params[:dob_month],
              year: account_params[:dob_year]
            },
            address: {
              line1: account_params[:address_line1],
              city: account_params[:address_city],
              state: account_params[:address_state],
              postal_code: account_params[:address_postal]
            },
            ssn_last_4: account_params[:ssn_last_4]
          },
          tos_acceptance: {
            date: Time.now.to_i,
            ip: request.remote_ip
          }
        )

        # If this is a business, update with these values
        if account_params[:account_type].eql?('company')
          stripe_account.legal_entity.business_name = \
            account_params[:business_name]
          stripe_account.legal_entity.business_tax_id = \
            account_params[:business_tax_id]
          stripe_account.save
        end

        # Save the account ID for this company for later
        @account.stripe_account_guid = stripe_account.id
        @account.save
        current_company.stripe_account_guid = stripe_account.id

        if current_company.save
          flash[:success] = "Your account has been created!
          Next, add a bank account where you'd like to receive transfers below."
          redirect_to new_bank_account_path
        else
          handle_error("Sorry, we weren't able to create this account.", 'new')
        end

        # Handle exceptions from Stripe
      rescue Stripe::StripeError => e
        handle_error(e.message, 'new')

        # Handle any other exceptions
      rescue => e
        handle_error(e.message, 'new')
      end
    else
      @full_account = true if params[:full_account]
      handle_error(@account.errors.full_messages)
    end
  end

  def edit
    # Check for a valid account ID
    unless params[:id] && params[:id].eql?(current_company.stripe_account_guid)
      flash[:danger] = "No Stripe account specified"
      return redirect_to authenticated_user_root_path
    end

    # Retrieve the Stripe account to find fields needed
    @stripe_account = Stripe::Account.retrieve(params[:id])

    # Retrieve the local account details
    @account = StripeAccount.find_by(stripe_account_guid: params[:id])

    if @stripe_account.verification.fields_needed.empty?
      flash[:success] = "Your information is all up to date."
      return redirect_to authenticated_user_root_path
    end
  end

  # Custom action for full account info collection
  def full
    @stripe_account = StripeAccount.new
    @full_account = true
  end

  def update
    # Check for an existing Stripe account
    unless current_company.stripe_account_guid
      return redirect_to new_stripe_account_path
    end

    begin
      # Retrieve the Stripe account
      @stripe_account = Stripe::Account.retrieve(current_company.stripe_account_guid)

      @account = StripeAccount.new(account_params)


      # Reject empty values
      account_params.each do |key, value|
        if value.empty?
          flash.now[:danger] = "Please complete all fields."
          return render 'edit'
        end
      end

      # Iterate through each field needed
      @stripe_account.verification.fields_needed.each do |field|

        # Update each needed attribute
        case field
        when 'legal_entity.address.city'
          @stripe_account.legal_entity.address.city = account_params[:address_city]
        when 'legal_entity.address.line1'
          @stripe_account.legal_entity.address.line1 = account_params[:address_line1]
        when 'legal_entity.address.postal_code'
          @stripe_account.legal_entity.address.postal_code = account_params[:address_postal]
        when 'legal_entity.address.state'
          @stripe_account.legal_entity.address.state = account_params[:address_state]
        when 'legal_entity.dob.day'
          @stripe_account.legal_entity.dob.day = account_params[:dob_day]
        when 'legal_entity.dob.month'
          @stripe_account.legal_entity.dob.month = account_params[:dob_month]
        when 'legal_entity.dob.year'
          @stripe_account.legal_entity.dob.year = account_params[:dob_year]
        when 'legal_entity.first_name'
          @stripe_account.legal_entity.first_name = account_params[:first_name]
        when 'legal_entity.last_name'
          @stripe_account.legal_entity.last_name = account_params[:last_name]
        when 'legal_entity.ssn_last_4'
          @stripe_account.legal_entity.ssn_last_4 = account_params[:ssn_last_4]
        when 'legal_entity.type'
          @stripe_account.legal_entity.type = account_params[:type]
        when 'legal_entity.personal_id_number'
          @stripe_account.legal_entity.personal_id_number = account_params[:personal_id_number]
        when 'legal_entity.verification.document'
          @stripe_account.legal_entity.verification.document = account_params[:verification_document]
        when 'legal_entity.business_name'
          @stripe_account.legal_entity.business_name = account_params[:business_name]
        when 'legal_entity.business_tax_id'
          @stripe_account.legal_entity.business_tax_id = account_params[:business_tax_id]
        end
      end

      @stripe_account.save
      flash[:success] = "Thanks! Your account has been updated."
      return redirect_to authenticated_user_root_path

      # Handle exceptions from Stripe
    rescue Stripe::StripeError => e
      handle_error(e.message, 'edit')

      # Handle any other exceptions
    rescue => e
      handle_error(e.message, 'edit')
    end
  end

  private

  def account_params
    params.require(:stripe_account).permit(
      :first_name, :last_name, :account_type, :dob_month, :dob_day, :dob_year, :tos,
      :ssn_last_4, :address_line1, :address_city, :address_state, :address_postal, :business_name,
      :business_tax_id, :full_account, :personal_id_number, :verification_document
    )
  end
end
