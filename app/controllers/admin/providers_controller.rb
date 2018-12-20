module Admin
  class ProvidersController < Admin::ApplicationController
    def show
      respond_to do |format|
        format.json { render json: requested_resource }
        format.html do
          render locals: {
            page: Administrate::Page::Show.new(dashboard, requested_resource),
          }
        end
      end
    end

    def destroy
      if requested_resource.soft_delete!
        flash[:notice] = translate_with_resource("destroy.success")
      else
        flash[:error] = requested_resource.errors.full_messages.join("<br/>")
      end
      redirect_to action: :index
    end

    def valid_action?(name, resource = resource_class)
      if current_user.shop? && %i[edit create update destroy].include?(name)
        return false
      end
      super
    end

    private

    def scoped_resource
      base_scope = Provider.alive
      if current_user.administrator? || current_user.shop?
        return base_scope
      end
      if current_user.provider?
        return base_scope.where(id: current_user.provider.id)
      end
      Provider.none
    end
  end
end
