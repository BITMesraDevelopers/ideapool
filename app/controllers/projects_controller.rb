class ProjectsController < ApplicationController
	def index
		@projects = Project.all
	end
	def archive
		@projects = Project.where(:completed => true)
	end
end
