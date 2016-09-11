class VolunteerAttrs < ActiveRecord::Migration[5.0]
  def change
		add_column :volunteers, :project_id, :integer
		add_column :volunteers, :user_id, :integer
  end
end
