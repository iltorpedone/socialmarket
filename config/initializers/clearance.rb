Clearance.configure do |config|
  config.mailer_sender = "info@socialmarketnordmi.org"
  config.rotate_csrf_on_sign_in = true
  config.allow_sign_up = false
  config.redirect_url = '/admin/beneficiaries'
end
