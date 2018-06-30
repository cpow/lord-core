class PropertyManagerInviterMailer < ApplicationMailer

  def invite(property_manager, company)
    @company = company
    @property_manager = property_manager
    subject = <<~HEREDOC
      You've been invited to join up with #{@company.name} on LivingRoom
    HEREDOC

    mail(to: email, subject: subject)
  end
end
