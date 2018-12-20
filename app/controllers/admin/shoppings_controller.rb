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
      unless resource.beneficiary.can_shop?
        redirect_to new_admin_shopping_path, notice: t('max_shops_alert')
        return
      end
      authorize_resource(resource)

      if resource.save
        redirect_to cart_admin_shopping_shopping_items_path(resource.id)
      else
        render :new, locals: {
          page: Administrate::Page::Form.new(dashboard, resource),
        }
      end
    end

    def update
      if requested_resource.update(resource_params)
        if resource_params[:status] == 'hard_closed'
          CloseShopping.(requested_resource.id)
        end
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

    def valid_action?(name, resource = resource_class)
      if current_user.shop?
        return false if %i[edit create update destroy].include?(name)
      end
      super
    end

    private

    def scoped_resource
      Shopping.for_user(current_user).ordered
    end
    helper_method :scoped_resource
  end
end
