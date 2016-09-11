class CommentAttrsAddType < ActiveRecord::Migration[5.0]
  def change
		add_column :comments, :comment_type, :string, :null => false
	end
end
