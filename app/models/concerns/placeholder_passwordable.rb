module PlaceholderPasswordable
  include ActiveSupport::Concern

  def set_placeholder_password
    self.password = unique_password
  end

  def unique_password
    @unique_password ||= SecureRandom.base58(24)
  end
end
