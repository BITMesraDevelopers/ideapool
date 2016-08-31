class ProjectInitialAttrs < ActiveRecord::Migration[5.0]
  def change
		add_column :projects, :title, :string
		add_column :projects, :description, :string
		add_column :projects, :likes, :integer
		add_column :projects, :time_required, :string
		add_column :projects, :status, :string
		add_column :projects, :url, :string
	end
end
