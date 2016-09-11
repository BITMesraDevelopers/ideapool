class Comment < ApplicationRecord
	belongs_to :project
	belongs_to :user
	has_many :attachments
	validates :comment_type,
		:inclusion  => { :in => COMMENT_TYPES,
		:message    => "%{value} is not a valid comment type" }
end
