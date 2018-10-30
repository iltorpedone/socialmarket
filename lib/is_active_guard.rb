class IsActiveGuard < Clearance::SignInGuard
  def call
    if current_user.is_active?
      next_guard
    else
      failure("L'utente non è attivo.")
    end
  end
end
