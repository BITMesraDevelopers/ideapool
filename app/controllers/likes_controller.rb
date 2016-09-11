class LikesController < ApplicationController
	def toggle
		begin
			user_id = view_context.get_session_user.id
			raise "No Project Id?" if !params[:id]
			existing_likes = Like.where(:user_id => user_id).where(:project_id => params[:id])
			likes = Project.find(params[:id]).likers.size
			if existing_likes.size == 0
				like = Like.create :user_id => user_id, :project_id => params[:id]
				if like
					render :json => {"success": true, "newtext": "Unlike", "newlikes": likes+1, "id": params[:id]}
				else
					render :json => {"success": false}
				end
			else
				existing_like = existing_likes[0]
				if existing_like.delete
					render :json => {"success": true, "newtext": "Like", "newlikes": likes-1, "id": params[:id]}
				else
					render :json => {"success": false}
				end
			end
		rescue Exception => e
			puts e
			render :json => {"success": false}
		end
	end
end
