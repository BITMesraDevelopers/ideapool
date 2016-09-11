class CommentAttrsAddProjectId < ActiveRecord::Migration[5.0]
  def change
		add_column :comments, :project_id, :integer
  end
end
