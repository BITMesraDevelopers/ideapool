class VolunteersController < ApplicationController
	def toggle
		begin
			user_id = view_context.get_session_user.id
			raise "No Project Id?" if !params[:id]
			existing_volunteers = Volunteer.where(:user_id => user_id).where(:project_id => params[:id])
			if existing_volunteers.size == 0
				volunteer = Volunteer.create :user_id => user_id, :project_id => params[:id]
				if volunteer
					render :json => {"success": true, "newtext": "Unvolunteer", "id": params[:id]}
				else
					render :json => {"success": false}
				end
			else
				existing_volunteer = existing_volunteers[0]
				if existing_volunteer.delete
					render :json => {"success": true, "newtext": "Volunteer", "id": params[:id]}
				else
					render :json => {"success": false}
				end
			end
		rescue Exception => e
			puts e
			render :json => {"success": false}
		end
	end
	
	def approve
		begin
			user = view_context.get_session_user
			if user and user.level.to_s == "10"
				volunteer = Volunteer.find(params[:id])
				member = Member.create(:project_id => volunteer.project_id, :user_id => volunteer.user_id)
				volunteer.delete
			end
		rescue Exception => e
			puts e.inspect
			redirect_to "/projects/unapproved", :notice => "Couldn't approve :("
		else
			redirect_to "/projects/unapproved", :notice => "Done."
		end
	end
	
	def deny
		begin
			user = view_context.get_session_user
			if user and user.level.to_s == "10"
				volunteer = Volunteer.find(params[:id])
				volunteer.delete
			end
		rescue Exception => e
			puts e.inspect
			redirect_to "/projects/unapproved", :notice => "Couldn't deny :("
		else
			redirect_to "/projects/unapproved", :notice => "Done."
		end
	end
end
