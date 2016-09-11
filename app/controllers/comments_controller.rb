class CommentsController < ApplicationController
	include ApplicationHelper
	
	def create
		err = nil
		begin
			user_id = view_context.get_session_user.id
			attachment_ids = JSON.parse(params[:attachments_for_comment])
			raise "No text or attachment for comment ??" if !(params[:comment][:comment_text] and	params[:comment][:comment_text].size > 0) and attachment_ids.size == 0
			c = Comment.create(:comment_text => params[:comment][:comment_text], :user_id => user_id, 
												 :project_id => flash[:project_id], :comment_type => params[:comment][:comment_type])
			puts params[:attachments_for_comment]
			attachment_ids.each do |attachment_id|
				c.attachments << Attachment.find(attachment_id)
			end
		rescue Exception => e
			puts e
			err = e
		end
		if c and !e
			flash[:content] = nil
			redirect_to "/projects/show/"+flash[:project_id].to_s, :notice => "Comment recorded!"
		else
			flash[:content] = params[:comment][:comment_text]
			redirect_to "/projects/show/"+flash[:project_id].to_s, :notice => "Comment could not be recorded :( (#{e.message})"
		end
	end
	
	def delete
		begin
			logged_in_user = view_context.get_session_user
			if logged_in_user and params[:id]
				req_comment = Comment.find(params[:id])
				user_associated_id = req_comment.user.id
				if user_associated_id == logged_in_user.id
					req_comment.attachments.each do |attachment|
						attachment.delete
					end
					req_comment.delete
				end
			end
		rescue Exception => e
			puts e
			redirect_to "/projects/show/"+flash[:project_id].to_s, :notice => "Comment could not be deleted :( Do you have the permissions?"
		else
			redirect_to "/projects/show/"+flash[:project_id].to_s, :notice => "Comment deleted!!"
		end
	end
end