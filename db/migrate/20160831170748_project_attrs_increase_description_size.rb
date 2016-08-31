class ProjectAttrsIncreaseDescriptionSize < ActiveRecord::Migration[5.0]
  def change
		change_column :projects, :description, :text, :limit => 4294967295
  end
end
