class AddDeletedToProviders < ActiveRecord::Migration[5.2]
  def change
    add_column :providers, :deleted, :boolean, default: false
    add_index :providers, :deleted
  end
end
