class User < ApplicationRecord
	has_many :sessions
	has_many :attachments
	has_many :comments
	has_many :likes
	has_many :liked_projects, :source => :project, :through => :likes
	has_many :volunteers
	has_many :applied_projects, :source => :project, :through => :volunteers
	has_many :members
	has_many :projects_member_of, :source => :project, :through => :members
	has_many :projects_owned, :class_name => "Project"
	# before saving, encrypt password
	before_create :encrypt_pass
	# to generate the hash
	validates_presence_of :password, :on => :create
	# username requirements
	validates_presence_of :username
	validates_uniqueness_of :username
	
	def encrypt_pass
		if password.present?
			self.salt = BCrypt::Engine.generate_salt
			self.password = BCrypt::Engine.hash_secret(password, salt)
		end
	end
	
	def is_admin?
		self.is_admin
	end
end
