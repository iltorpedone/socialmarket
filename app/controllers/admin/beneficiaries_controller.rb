module Admin
  class BeneficiariesController < Admin::ApplicationController
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
