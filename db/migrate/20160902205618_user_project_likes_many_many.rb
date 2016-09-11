class UserProjectLikesManyMany < ActiveRecord::Migration[5.0]
  def change
    add_column :likes, :user_id, :integer
    add_column :likes, :project_id, :integer
		remove_column :projects, :likes
	end
end
