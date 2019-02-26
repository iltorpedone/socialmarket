require "administrate/field/belongs_to"

class ShoppingBeneficiaryField < Administrate::Field::BelongsTo
  def candidate_resources
    scope = super
    if resource.provider_id?
      scope.where(provider_id: resource.provider_id)
    else
      scope
    end
  end

  def display_candidate_resource(resource)
    resource.full_name_by_last_name
  end
end
