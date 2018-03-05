class InviteUserToPropertyMailer < ApplicationMailer
  def invite(residency)
    @user = residency.user
    @property = residency.property
    @unit = residency.unit
    @company = residency.company

    subject = "Welcome to the neighborhood. From #{@company.name}"

    mail to: @user.email, subject: subject, from: @company.property_managers.first.email
  end
end
