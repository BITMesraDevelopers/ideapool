class ProjectAttrsSpecifyDefaults < ActiveRecord::Migration[5.0]
	def change
		Project.where(:likes => nil).update_all(:likes => 0)
  	change_column :projects, :likes, :integer, :default => 0, :null => false
		Project.where(:time_required => nil).update_all(:time_required => "unknown")
		change_column :projects, :time_required, :string, :default => "unknown", :null => false
		Project.where(:status => nil).update_all(:status => "unknown")
		change_column :projects, :status, :string, :default => "unknown", :null => false
	end
end
