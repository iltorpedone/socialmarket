class RemoveCodeFromShoppings < ActiveRecord::Migration[5.2]
  def change
    remove_column :shoppings, :code, :string
  end
end
