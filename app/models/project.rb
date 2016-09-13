class Project < ApplicationRecord
	has_many :comments
	has_many :likes
	has_many :likers, :source => :user, :through => :likes
	has_many :volunteers
	has_many :volunteer_users, :source => :user, :through => :volunteers
	has_many :members
	has_many :member_users, :source => :user, :through => :members
	belongs_to :user
	alias_attribute :owner, :user
end
