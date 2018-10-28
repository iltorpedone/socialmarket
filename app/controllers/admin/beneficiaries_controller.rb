module Admin
  class BeneficiariesController < Admin::ApplicationController
    # To customize the behavior of this controller,
    # you can overwrite any of the RESTful actions. For example:
    #
    end

    # Define a custom finder by overriding the `find_resource` method:
    # def find_resource(param)
    #   Beneficiary.find_by!(slug: param)
    # end
    private

    def scoped_resource
      scope = if current_user.provider?
        current_user.provider.beneficiaries
      else
        resource_class
      end
      scope.ordered
    end

    # See https://administrate-prototype.herokuapp.com/customizing_controller_actions
    # for more information
  end
end
