class Residency::CreateFromProperty
  attr_accessor :residency

  def initialize(property:, residency:)
    @property = property
    @residency = residency
  end

  def save
    @residency.transaction do
      create_user_from_email
      update_join_ids
      @residency.save!
    end

    mail_invite_to_residency

    true
  rescue ActiveRecord::RecordInvalid
    false
  end

  private

  def update_join_ids
    @residency.company_id = @property.company_id
  end

  def mail_invite_to_residency
    InviteUserToPropertyMailer.invite(@residency).deliver_later
  end

  def create_user_from_email
    user = User.find_or_initialize_by(email: @residency.user_email)

    unless user.activated
      user.set_placeholder_password
      user.save!
    end

    @residency.user_id = user.id
  end
end
