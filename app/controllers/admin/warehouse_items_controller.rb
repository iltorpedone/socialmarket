module Admin
  class WarehouseItemsController < Admin::ApplicationController
    def index
      search_term = params[:search].to_s.strip
      respond_to do |format|
        format.json { render json: scoped_resource }
        format.html do
          resources = Administrate::Search.new(scoped_resource,
                                               dashboard_class,
                                               search_term).run
          resources = apply_resource_includes(resources)
          resources = order.apply(resources)
          resources = resources.page(params[:page]).per(records_per_page)
          page = Administrate::Page::Collection.new(dashboard, order: order)

          render locals: {
            resources: resources,
            search_term: search_term,
            page: page,
            show_search_bar: show_search_bar?,
          }
        end
      end
    end

    private

    def scoped_resource
      scope = WarehouseItem.all
      if params[:item_category_id].present?
        scope.where(item_category_id: params[:item_category_id])
      else
        scope
      end
    end
  end
end
