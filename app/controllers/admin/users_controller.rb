module Admin
  class UsersController < Admin::ApplicationController
    def create
      resource = resource_class.new(resource_params)
      resource.password = SecureRandom.hex(16) # sets this randomly because Clearance validations require it but the user is not active at this point.
      resource.signup_token = SecureRandom.hex(16)
      authorize_resource(resource)

      if resource.save
        AdminMailer.
          with(user: resource).
          complete_signup.
          deliver_now
        if resource.provider?
          Provider.create!(
            name: resource.full_name,
            user: resource,
            email: resource.email,
          )
        end
        redirect_to(
          [namespace, resource],
          notice: translate_with_resource("create.success"),
        )
      else
        render :new, locals: {
          page: Administrate::Page::Form.new(dashboard, resource),
        }
      end
    end

    def update
      attributes = resource_params
      if attributes[:password].blank?
        attributes.delete(:password)
      end
      if requested_resource.update(attributes)
        redirect_to(
          [namespace, requested_resource],
          notice: translate_with_resource("update.success"),
        )
      else
        render :edit, locals: {
          page: Administrate::Page::Form.new(dashboard, requested_resource),
        }
      end
    end

    def destroy
      provider = if requested_resource.provider?
        requested_resource.provider
      end
      if requested_resource.soft_delete!
        flash[:notice] = translate_with_resource("destroy.success")
      else
        flash[:error] = requested_resource.errors.full_messages.join("<br/>")
      end
      redirect_to action: :index
    end

    def activate
      user = User.find(params[:id])
      user.make_active!
      UserMailer.
        with(user: user).
        activation.
        deliver_now
      redirect_to admin_user_path(user), notice: 'Utente attivato.'
    end

    private

    def scoped_resource
      base_scope = User.alive
      return base_scope if current_user.administrator?
      base_scope.where(id: current_user.id)
    end
  end
end
