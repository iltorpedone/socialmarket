class AddDeletedToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :deleted, :boolean, default: false
    add_index :users, :deleted
  end
end
