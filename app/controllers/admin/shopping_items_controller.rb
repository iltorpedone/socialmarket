module Admin
  class ShoppingItemsController < Admin::ApplicationController
    # To customize the behavior of this controller,
    # you can overwrite any of the RESTful actions. For example:
    #

    def scoped_resource
      scope = ShoppingItem.all
      if params[:shopping_id].present?
        scope.where(shopping_id: params[:shopping_id])
      else
        scope
      end
    end

    def new
      resource = resource_class.new
      if params[:shopping_id].present?
        resource.shopping_id = params[:shopping_id]
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
        redirect_to(
          admin_shopping_path(resource.shopping_id),
          notice: translate_with_resource("create.success"),
        )
      else
        render :new, locals: {
          page: Administrate::Page::Form.new(dashboard, resource),
        }
      end
    end

    def update
      if requested_resource.update(resource_params)
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
      back_path = admin_shopping_path(requested_resource.shopping_id)
      if requested_resource.destroy
        flash[:notice] = translate_with_resource("destroy.success")
      else
        flash[:error] = requested_resource.errors.full_messages.join("<br/>")
      end
      redirect_to back_path
    end

    # Define a custom finder by overriding the `find_resource` method:
    # def find_resource(param)
    #   ShoppingItem.find_by!(slug: param)
    # end

    # See https://administrate-prototype.herokuapp.com/customizing_controller_actions
    # for more information
  end
end
