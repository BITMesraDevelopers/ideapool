class ProjectAttrsAddApproval < ActiveRecord::Migration[5.0]
  def change
		add_column :projects, :approved, :boolean, :default => false
  end
end
