module Admin
  class BeneficiariesController < Admin::ApplicationController
    def show
      respond_to do |format|
        format.json { render json: requested_resource }
        format.html do
          # TODO: detect the request (maybe using an extra parameter?) and render accordingly (layout: false, no buttons, etc.)
          if request.xhr?
            render locals: { requested_resource: requested_resource }
          else
            render locals: {
              page: Administrate::Page::Show.new(dashboard, requested_resource),
            }
          end
        end
      end
    end

    def create
      resource = resource_class.new(resource_params)
      if current_user.provider?
        resource.provider_id = current_user.provider.id
        resource.is_active = false
      end
      authorize_resource(resource)

      if resource.save
        AdminMailer.with(beneficiary: resource).confirm_new_beneficiary.deliver_now
        redirect_to(
          admin_beneficiaries_path,
          notice: translate_with_resource("create.success"),
        )
      else
        render :new, locals: {
          page: Administrate::Page::Form.new(dashboard, resource),
        }
      end
    end

    def update
      proposed_changed = resource_params[:proposed_max_shop_count].present? && resource_params[:proposed_max_shop_count] != requested_resource.proposed_max_shop_count
      if requested_resource.update(resource_params)
        if proposed_changed
          AdminMailer.
            with(beneficiary: requested_resource).
            confirm_beneficiary_proposed_max_shop_count.
            deliver_now
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

    def confirmation
      # TODO: add authorization.
      # Only administrators can perform this action.
      # Check the definition of `AuthorizeRole`.
      @beneficiary = Beneficiary.find_by(id: params[:id])
      unless @beneficiary
        redirect_to admin_beneficiaries_path, notice: 'Il beneficiario richiesto non esiste.'
      end
      if @beneficiary.is_active?
        redirect_to admin_beneficiary_path(@beneficiary), notice: 'Il beneficiario è già stato confermato.'
      end
    end

    def confirm
      # TODO: add authorization.
      # Only administrators can perform this action.
      # Check the definition of `AuthorizeRole`.
      @beneficiary = Beneficiary.find(params[:id])
      @beneficiary.make_active!
      redirect_to admin_beneficiary_path(@beneficiary), notice: 'Activated!'
    end

    def deny_confirmation
      # TODO: add authorization.
      # Only administrators can perform this action.
      # Check the definition of `AuthorizeRole`.
      beneficiary = Beneficiary.find(params[:id])
      beneficiary.delete
      redirect_to admin_root_path, notice: 'Beneficiary deleted'
    end

    def confirmation_max_shop_count
      # TODO: add authorization.
      # Only administrators can perform this action.
      # Check the definition of `AuthorizeRole`.
      @beneficiary = Beneficiary.find_by(id: params[:id])
      unless @beneficiary
        redirect_to admin_beneficiaries_path, notice: 'Il beneficiario richiesto non esiste.'
      end
      if @beneficiary.proposed_max_shop_count.blank?
        redirect_to admin_beneficiary_path(@beneficiary), notice: 'Il beneficiario non ha alcuna soglia di spesa massima proposta.'
      end
    end

    def confirm_max_shop_count
      # TODO: add authorization.
      # Only administrators can perform this action.
      # Check the definition of `AuthorizeRole`.
      beneficiary = Beneficiary.find(params[:id])
      beneficiary.max_shop_count = beneficiary.proposed_max_shop_count
      beneficiary.proposed_max_shop_count = nil
      beneficiary.save!
      redirect_to admin_beneficiary_path(beneficiary), notice: 'Nuova soglia confermata!'
    end

    def deny_confirmation_max_shop_count
      # TODO: add authorization.
      # Only administrators can perform this action.
      # Check the definition of `AuthorizeRole`.
      beneficiary = Beneficiary.find(params[:id])
      beneficiary.proposed_max_shop_count = nil
      beneficiary.save!
      redirect_to admin_beneficiary_path(beneficiary), notice: 'Soglia negata.'
    end

    private

    def scoped_resource
      scope = if current_user.provider?
        current_user.provider.beneficiaries
      else
        resource_class
      end
      scope.ordered
    end

  end
end
