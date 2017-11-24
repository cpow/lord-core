# Preview all emails at http://localhost:3000/rails/mailers/invite_user_to_property
require 'factory_bot'

class InviteUserToPropertyPreview < ActionMailer::Preview
  def invite
    residency = Residency.first
    InviteUserToPropertyMailer.invite(residency)
  end
end
