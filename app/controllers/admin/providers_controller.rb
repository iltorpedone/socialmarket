module Admin
  class ProvidersController < Admin::ApplicationController

    def destroy
      if requested_resource.soft_delete!
        flash[:notice] = translate_with_resource("destroy.success")
      else
        flash[:error] = requested_resource.errors.full_messages.join("<br/>")
      end
      redirect_to action: :index
    end

    private

    def scoped_resource
      base_scope = Provider.alive
      return base_scope if current_user.administrator?
      base_scope.where(id: current_user.provider.id)
    end
  end
end
