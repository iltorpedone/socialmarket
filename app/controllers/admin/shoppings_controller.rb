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
      # TODO wrap every write operations within a form object
      if resource_params[:status] == 'soft_closed'
        result = ValidateShoppingTotal.call(
          point_rank: requested_resource.beneficiary.point_rank,
          total: requested_resource.total,
        )
        if result.error?
          redirect_to cart_admin_shopping_shopping_items_path(requested_resource.id), alert: I18n.t('cart.points_not_allowed')
          return
        end
      end
      if requested_resource.update(resource_params)
        if resource_params[:status] == 'hard_closed'
          result = CloseShopping.(requested_resource.id)
          if result.error?
            requested_resource.soft_closed!
            redirect_to cart_admin_shopping_shopping_items_path(requested_resource.id), alert: I18n.t("cart.#{result.code}")
            return
          end
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

    def destroy
      result = DeleteShopping.call(shopping: requested_resource)
      if result.success?
        flash[:notice] = translate_with_resource("destroy.success")
      else
        flash[:error] = requested_resource.errors.full_messages.join("<br/>")
      end
      redirect_to action: :index
    end

 def valid_action?(name, resource = resource_class)
      if current_user.shop?
        return false if %i[edit create update destroy].include?(name)
      end
      super
    end

    private

    def scoped_resource
      scope = Shopping.for_user(current_user)
      direction = params.dig(:shopping, :direction)
      return scope.ordered unless direction

      Shopping.order_by(
        scope: scope,
        field: params.dig(:shopping, :order),
        direction: direction,
      )
    end
    helper_method :scoped_resource
  end
end
