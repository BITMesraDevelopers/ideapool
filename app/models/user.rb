class User < ApplicationRecord
	# before saving, encrypt password
	before_save :encrypt_pass
	# to generate the hash
	validates_presence_of :password, :on => :create
	# username requirements
	validates_presence_of :username
	validates_uniqueness_of :username
	
	def authenticate(username, password)
		user = User.find_by_username(username)
		if user and user.password == BCrypt::Engine.hash_secret(password, user.salt)
			return user
		else
			return nil
		end
	end
	
	def encrypt_pass
		if password.present?
			self.salt = BCrypt::Engine.generate_salt
			self.password = BCrypt::Engine.hash_secret(password, salt)
		end
	end
end