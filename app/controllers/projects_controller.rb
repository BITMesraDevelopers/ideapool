class ProjectsController < ApplicationController
	def create
		@project = Project.new
	end
	
	def makeproject
		begin
			user = view_context.get_session_user
			@project = Project.new(params[:project].permit(:title, :description, :time_required, :status))
			if user.level.to_s == "10"
				@project.approved = true
			end
			@project.owner = user
			@project.save
			@project.reload
			Member.create(:user_id => user.id, :project_id => @project.id)
		rescue Exception => e
			puts e.inspect
			redirect_to "/projects/create", :notice => "Something went wrong :("
		else
			if user.level.to_s == "10"
				redirect_to "/projects/show", :notice => "Created!"
			else
				redirect_to "/projects/show", :notice => "Submitted successfully, pending approval by an admin :)"
			end
		end
	end
	
	def unapproved
		@projects_unapproved = Project.where(:approved => false)
		@volunteers = Volunteer.all
	end
	
	def approve
		begin
			user = view_context.get_session_user
			if user and user.level.to_s == "10"
				project = Project.find(params[:id])
				project.approved = true
				project.save
			end
		rescue Exception => e
			puts e.inspect
			redirect_to "/projects/#{params[:last]}", :notice => "Approval failed :("
		else
			redirect_to "/projects/#{params[:last]}", :notice => "Approved."
		end
	end
	
	def my
		# Show a non-admin's projects.
		begin
			user = view_context.get_session_user
			@projects = Project.where(:owner => user)
		rescue Exception => e
			puts e.inspect
		else
		end
	end
	
	def destroyproject
		begin
			user = view_context.get_session_user
			project = Project.find(params[:id])
			if user and (user.level.to_s == "10" or (project.owner == user and !project.approved))
				project.delete
			else
				redirect_to "/projects/#{params[:last]}", :notice => "Delete failed :("	
			end
		rescue Exception => e
			puts e.inspect
			redirect_to "/projects/#{params[:last]}", :notice => "Delete failed :("
		else
			redirect_to "/projects/#{params[:last]}", :notice => "Deleted."
		end
	end
	
	def show
		if !params[:id]
			projects_unsorted = Project.where(:approved => true)
			projects_double_arr = projects_unsorted.collect {|p| [p.likers.size, p]}
			projects_double_arr.sort!.reverse!
			@projects = projects_double_arr.collect {|el| el[1]}
		else
			@project = Project.find_by_id(params[:id])
			flash[:project_id] = params[:id]
		end
	end
	
	def archive
		# Something can be completed only after it is approved
		projects_unsorted = Project.where(:completed => true)
		projects_double_arr = projects_unsorted.collect {|p| [p.likers.size, p]}
		projects_double_arr.sort!.reverse!
		@projects = projects_double_arr.collect {|el| el[1]}
	end
end
