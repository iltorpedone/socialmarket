class AddAppRoleToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :app_role, :integer, default: 0
  end
end
