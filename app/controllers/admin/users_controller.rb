module Admin
  class UsersController < Admin::ApplicationController
    def create
      resource = resource_class.new(resource_params)
      authorize_resource(resource)

      if resource.save
        if resource.provider?
          Provider.create(
            name: resource.full_name,
            user: resource,
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
      if requested_resource.destroy
        provider.destroy if provider
        flash[:notice] = translate_with_resource("destroy.success")
      else
        flash[:error] = requested_resource.errors.full_messages.join("<br/>")
      end
      redirect_to action: :index
    end

    private

    def scoped_resource
      unless current_user.administrator?
        User.where(id: current_user.id)
      end
      User.all
    end
  end
end
