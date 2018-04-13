class EmployerMailer < ApplicationMailer

  def send_reset_password_link(employer)
    @employer = employer
    mail(to: @employer.email, subject: 'Reset Your password')
  end
end
