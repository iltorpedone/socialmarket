module Admin
  class ShoppingItemsController < Admin::ApplicationController

    def cart
      @form = CartForm.new(user: current_user, shopping_id: params[:shopping_id])
      unless @form.shopping.opened?
        redirect_to admin_shopping_path(@form.shopping.id), notice: 'È possibile visualizzare il carrello solo se la spesa è aperta.'
      end
    end

    def bulk_add
      form = CartForm.new(user: current_user, shopping_id: params[:shopping_id])
      form.bulk_add(params[:items])
      render json: { success: true } # TODO: return proper error result
    end

    def destroy
      back_path = params[:back_path] || admin_shopping_path(requested_resource.shopping_id)
      shopping = Shopping.find_by(id: requested_resource.shopping_id)
      if requested_resource.destroy
        if shopping
          shopping.update_total!
        end
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
