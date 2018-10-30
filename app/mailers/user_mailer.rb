class UserMailer < ApplicationMailer
  def activation
    @user = params[:user]
    mail(to: @user.email, subject: 'Il tuo profilo è stato attivato')
  end
end
