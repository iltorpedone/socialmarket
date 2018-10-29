class User < ApplicationRecord
  include Clearance::User
  enum app_role: [ :administrator, :provider, :shop, :warehouse_worker ]
  has_one :provider

  scope :admin, -> { where(app_role: :administrator) }
end
