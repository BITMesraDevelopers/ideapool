class AttachmentsController < ApplicationController
	def upload
		begin
			user_id = view_context.get_session_user.id
			if params["file"]
				attachment = Attachment.create(:file => params["file"], :user_id => user_id)
			end
		rescue Exception => e
			puts e
		end
		if attachment and attachment.id
			render :json => {"success": true, "id": attachment.id, "url": attachment.file.url, "name": attachment.file_file_name}
		else
			render :json => {"success": false}
		end
	end
	
	def delete
		begin
			user_id = view_context.get_session_user.id
			attachment_id = params[:attachmentid]
			attachment = Attachment.find_by_id(attachment_id)
			if attachment.user_id == user_id
				attachment.delete
				render :json => {"success": true, "id": attachment_id}
			else
				render :json => {"success": false}
			end
		rescue Exception => e
			puts e
			render :json => {"success": false}
		end		
	end
end
