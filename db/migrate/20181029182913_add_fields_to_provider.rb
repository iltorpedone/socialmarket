class AddFieldsToProvider < ActiveRecord::Migration[5.2]
  def change
    add_column :providers, :telephone, :string
    add_column :providers, :email, :string
    add_index :providers, :email
    add_column :providers, :referent, :string
    add_column :providers, :address, :string
    add_column :providers, :city_id, :integer
    add_index :providers, :city_id
  end
end
