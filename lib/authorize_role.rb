class AuthorizeRole
  attr_accessor :user, :controller, :action, :scoped_resource, :requested_resource
  include ActiveModel::Model

  def can?
    if !user.administrator?
      found = [
        -> {
          controller == 'admin/users' &&
            %w[destroy activate].include?(action)
        },
      ].find do |condition|
        condition.call
      end
      return false if found
    end

    case user.app_role
    when 'administrator' then true
    when 'provider' then can_provider?
    when 'shop' then can_shop?
    when 'warehouse_worker' then can_warehouse_worker?
    else
      false
    end
  end

  def can_provider?
    # TODO: implement me
    if controller == 'admin/users'
      return false if ['new', 'create', 'delete'].include?(action)
      if ['new', 'edit', 'update'].include?(action)
        return requested_resource.id == user.id
      end
    end
    true
  end

  def can_shop?
    # TODO: implement me
    true
  end

  def can_warehouse_worker?
    # TODO: implement me
    true
  end
end
