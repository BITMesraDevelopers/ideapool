class MembersController < ApplicationController
	def revoke
		begin
			user = view_context.get_session_user
			member = Member.find(params[:id])
			last = params[:last] ? params[:last] : "show"
			if user and (user.level.to_s == "10" or Project.find(member.project_id).owner == user)
				member.delete
			end
		rescue Exception => e
			puts e.inspect
			redirect_to "/projects/#{last}", :notice => "Couldn't revoke :("
		else
			redirect_to "/projects/#{last}", :notice => "Done."
		end
	end
end
