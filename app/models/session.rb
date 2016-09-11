class Session < ApplicationRecord
	belongs_to :user
	before_save :generate_stuff
	validates_presence_of :user_id

	def session_for(valid_until_, token_salt_)
		session = Session.where(:valid_until => valid_until_).where(:token_salt => token_salt_)
		if session.size == 1 and session[0].token_final == BCrypt::Engine.hash_secret(valid_until_, token_salt_)
			return session
		else
			return nil
		end
	end
	
	def generate_stuff
		self.token_salt = BCrypt::Engine.generate_salt
		self.valid_until = (Time.now+60*60*24).strftime('%Y-%m-%d %H:%M:%S')
		self.token_final = BCrypt::Engine.hash_secret(valid_until.to_s, self.token_salt)
	end
end
