class AuthorizeRole
  attr_accessor :user, :controller, :action, :resource
  include ActiveModel::Model

  def can?
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
