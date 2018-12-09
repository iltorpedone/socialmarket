class AdminMailer < ApplicationMailer
  def confirm_new_beneficiary
    @beneficiary = params[:beneficiary]
    to = User.admin.map do |user|
      "\"#{user.full_name}\" <#{user.email}>"
    end
    mail(to: to, subject: 'Conferma nuovo beneficiario')
  end

  def notify_beneficiary_confirmation
    @beneficiary = params[:beneficiary]
    @provider = @beneficiary.provider
    mail(to: @provider.email, subject: 'Nuovo beneficiario confermato')
  end

  def confirm_beneficiary_proposed_max_shop_count
    @beneficiary = params[:beneficiary]
    to = User.admin.map do |user|
      "\"#{user.full_name}\" <#{user.email}>"
    end
    mail(to: to, subject: 'Conferma variazione di soglia massima di spesa')
  end

  def complete_signup
    @user = params[:user]
    mail(to: @user.email, subject: 'Completa il tuo profilo')
  end

  def signup_completion
    @user = params[:user]
    to = User.admin.map do |user|
      "\"#{user.full_name}\" <#{user.email}>"
    end
    mail(to: to, subject: 'Nuovo profilo completato')
  end
end
