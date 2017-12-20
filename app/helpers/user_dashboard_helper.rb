module UserDashboardHelper
  INFO_CLASS = 'alert-info'.freeze
  INFO_BUTTON_CLASS = 'btn btn-info'.freeze
  WARNING_CLASS = 'alert-warning'.freeze
  WARNING_BUTTON_CLASS = 'btn btn-warning'.freeze
  DANGER_CLASS = 'alert-danger'.freeze
  DANGER_BUTTON_CLASS = 'btn btn-danger'.freeze
  PRIMARY_BUTTON_CLASS = 'btn btn-primary'.freeze

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

  def plaid_card_link_text
    if hasnt_signed_up?
      'Add Bank Account'
    else
      'Change Account'
    end
  end

  def plaid_card_button_class
    hasnt_signed_up? ? WARNING_BUTTON_CLASS : PRIMARY_BUTTON_CLASS
  end

  private

  def hasnt_signed_up?
    @user.needs_to_sign_up_for_plaid?
  end
end
