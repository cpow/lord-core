module UserDashboardHelper
  INFO_CLASS = 'alert-info'.freeze
  INFO_BUTTON_CLASS = 'btn btn-info'.freeze
  WARNING_CLASS = 'alert-warning'.freeze
  WARNING_BUTTON_CLASS = 'btn btn-warning'.freeze
  DANGER_CLASS = 'alert-danger'.freeze
  DANGER_BUTTON_CLASS = 'btn btn-danger'.freeze
  PRIMARY_BUTTON_CLASS = 'btn btn-primary'.freeze

  #returns an object telling the card what to do :)
  def lease_payment_style
    if @lease_payment.payment_late?
      OpenStruct.new(
        card_class: DANGER_CLASS,
        button_class: DANGER_BUTTON_CLASS,
        button_text: 'Make Late Payment'
      )
    elsif @lease_payment.payment_due?
      OpenStruct.new(
        card_class: WARNING_CLASS,
        button_class: WARNING_BUTTON_CLASS,
        button_text: 'Make Payment'
      )
    elsif @lease_payment.payment_within_reminder_period?
      OpenStruct.new(
        card_class: INFO_CLASS,
        button_class: INFO_BUTTON_CLASS,
        button_text: 'Make Payment'
      )
    else
      OpenStruct.new(
        card_class: '',
        button_class: 'btn btn-light',
        button_text: 'Make Payment'
      )
    end
  end

  def plaid_card_class
    hasnt_signed_up? ? WARNING_CLASS : ''
  end

  def plaid_card_button
    if hasnt_signed_up?
      link_to "Add Bank Account", new_tenant_plaid_account_path, class: plaid_card_button_class
    end
  end

  def plaid_card_button_class
    hasnt_signed_up? ? WARNING_BUTTON_CLASS : PRIMARY_BUTTON_CLASS
  end

  def plaid_account_message
    if @user.needs_to_sign_up_for_plaid?
      'You need to add your bank account here in order to pay rent for the month. :)'
    else
      'Congrats! you added your bank account'
    end
  end

  private

  def hasnt_signed_up?
    @user.needs_to_sign_up_for_plaid?
  end
end
