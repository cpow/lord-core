class Residency::CreateFromProperty
  attr_accessor :residency

  def initialize(property:, residency:, manager:)
    @property = property
    @residency = residency
    @manager = manager
  end

  def save
    begin
      create_user_from_email
      return Residency::EXISTS if residency_with_user_exists
      add_user_to_residency
      update_join_ids
      @residency.save!
      mail_invite_to_residency
      create_event_for_residency
      Residency::SUCCESS
    rescue ActiveRecord::RecordInvalid
      return Residency::ERROR
    end
  end

  private

  def create_event_for_residency
    Event.create!(eventable: @residency,
                  event_type: Event::EVENT_CREATED,
                  createable: @manager)
  end

  def residency_with_user_exists
    !@user.new_record? && Residency.active.where(user_id: @user.id).present?
  end

  def update_join_ids
    @residency.company_id = @property.company_id
  end

  def mail_invite_to_residency
    InviteUserToPropertyMailer.invite(@residency).deliver_later
  end

  def create_user_from_email
    @user ||= User.find_or_initialize_by(email: @residency.user_email)

  end

  def add_user_to_residency
    unless @user.activated
      @user.set_placeholder_password
      @user.save!
    end

    @residency.user_id = @user.id
  end
end
