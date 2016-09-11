module ApplicationHelper
	def get_session_user
		if !cookies[:__a] or !cookies[:__b]
			return nil
		end
		salt_ = Base64.decode64 cookies[:__a]
		valid_until_ = Base64.decode64 cookies[:__b]
		if Time.now <= valid_until_.to_time
			sessions = Session.where(:token_salt => salt_)
			if sessions.size == 1
				session = sessions[0]
				if session.valid_until == valid_until_
					return User.find_by_id(session.user_id)
				end
			end
		end
		return nil
	end
end
