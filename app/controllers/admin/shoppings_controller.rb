module Admin
  class ShoppingsController < Admin::ApplicationController
    def new
      resource = resource_class.new
      if current_user.provider?
        resource.provider_id = current_user.provider.id
      end
      authorize_resource(resource)
      render locals: {
        page: Administrate::Page::Form.new(dashboard, resource),
      }
    end

    def create
      resource = resource_class.new(resource_params)
      authorize_resource(resource)

      if resource.save
        redirect_to cart_admin_shopping_shopping_items_path(resource.id)
      else
        render :new, locals: {
          page: Administrate::Page::Form.new(dashboard, resource),
        }
      end
    end
  end
end
