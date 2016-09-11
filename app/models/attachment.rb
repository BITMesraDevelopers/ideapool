class Attachment < ApplicationRecord
	has_one :comment
	belongs_to :user
	has_attached_file :file
	validates_attachment_size :file, :in => 0.megabytes..MAX_ATTACHMENT_SIZE.megabytes
	do_not_validate_attachment_file_type :file
end
