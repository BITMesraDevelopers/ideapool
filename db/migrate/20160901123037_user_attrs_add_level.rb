class UserAttrsAddLevel < ActiveRecord::Migration[5.0]
  def change
		add_column :users, :level, :integer, :default => 1, :null => false
  end
end
