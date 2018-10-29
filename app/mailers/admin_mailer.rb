class AdminMailer < ApplicationMailer
  def confirm_new_beneficiary
    @beneficiary = params[:beneficiary]
    to = User.admin.map do |user|
      "\"#{user.full_name}\" <#{user.email}>"
    end
    mail(to: to, subject: 'Conferma nuovo beneficiario')
  end
end
