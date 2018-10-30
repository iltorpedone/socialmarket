class AddSignupTokenToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :signup_token, :string
    add_index :users, :signup_token
  end
end
