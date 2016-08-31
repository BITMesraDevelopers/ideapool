class AddUserAttrs < ActiveRecord::Migration[5.0]
  def change
		add_column :users, :username, :string, :null => false
		add_column :users, :password, :string, :null => false
		add_column :users, :salt, :string, :null => false
  end
end
