class AttachmentAttrsAddUserDependency < ActiveRecord::Migration[5.0]
  def change
		add_column :attachments, :user_id, :integer
  end
end
