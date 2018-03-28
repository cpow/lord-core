class Notifications::Unread
  def initialize(event)
    @event = event
  end

  def users
    if @event&.unit
      @event.unit.users.reject { |user| @event.has_been_read_by?(user) }
    end
  end

  def managers
    if @event&.property
      @event.property.property_managers.reject do |manager|
        @event.has_been_read_by?(manager)
      end
    end
  end
end
