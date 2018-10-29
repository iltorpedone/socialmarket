class AdminMailer < ApplicationMailer
  def confirm_new_beneficiary
    @beneficiary = params[:beneficiary]
    to = User.admin.map do |user|
      "\"#{user.full_name}\" <#{user.email}>"
    end
    mail(to: to, subject: 'Conferma nuovo beneficiario')
  end

  def confirm_beneficiary_proposed_max_shop_count
    @beneficiary = params[:beneficiary]
    to = User.admin.map do |user|
      "\"#{user.full_name}\" <#{user.email}>"
    end
    mail(to: to, subject: 'Conferma variazione di soglia massima di spesa')
  end
end
