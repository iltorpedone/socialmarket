module Admin
  class ShoppingItemsController < Admin::ApplicationController

    def cart
      @form = CartForm.new(user: current_user, shopping_id: params[:shopping_id])
    end

    def bulk_add
      # TODO: implement me
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

    private

    def scoped_resource
      scope = ShoppingItem.all
      if params[:shopping_id].present?
        scope.where(shopping_id: params[:shopping_id])
      else
        scope
      end
    end
  end
end
