class SignupCompletionsController < ApplicationController
  before_action :require_valid_token

  def new
  end

  def create
    attributes = {
      password: params[:password],
      signup_token: nil,
    }
    if @user.update(attributes)
      AdminMailer.with(user: @user).signup_completion.deliver_now
      redirect_to sign_in_path, notice: 'Il tuo profilo è stato notificato agli amministratori che dovranno attivarlo per permetterti di accedere.'
    else
      flash[:error] = @user.errors.full_messages.join("\n")
      render :new
    end
  end

  private

  def require_valid_token
    @user = User.find_by(signup_token: params[:token])
    unless @user
      redirect_to root_path, notice: 'Link non valido.'
      return
    end
  end
end
