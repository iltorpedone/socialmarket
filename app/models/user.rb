class User < ApplicationRecord
  include Clearance::User
  enum app_role: [ :administrator, :provider, :shop, :warehouse_worker ]
  has_one :provider

  scope :alive, -> { where(deleted: false) }
  scope :deleted, -> { where(deleted: true) }
  scope :admin, -> { where(app_role: :administrator) }

  def make_active!
    update(is_active: true)
  end

  def soft_delete!
    result = update(deleted: true, email: "__deleted__#{email}")
    return result unless result

    if provider? && !provider.deleted?
      result = provider.soft_delete!
      return result unless result
    end
    true
  end
end
