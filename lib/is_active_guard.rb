class IsActiveGuard < Clearance::SignInGuard
  def call
    return next_guard unless signed_in?
    if current_user.is_active?
      next_guard
    else
      failure("L'utente non è attivo.")
    end
  end
end
