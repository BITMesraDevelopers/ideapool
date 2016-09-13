class UsersController < ApplicationController
	def login
		if !flash[:username]
			@user = User.new
			flash[:referrer] = request.referrer
		else
			# If you tried logging in previously, I have your username, you don't need to type again :)
			@user = User.new(:username => flash[:username])
			# Also, I'll redirect you to the correct referrer
			flash.keep
		end
	end
	
	def makesession
		username = params[:user][:username]
		password = params[:user][:password]
		timed_out = false
		begin
			get_request = "http://"+DCHUB_URL+"?nick="+username+"&password="+password+"&secret="+DC_API_KEY
			response = {}
			Timeout.timeout(3) {
				response = JSON.parse(Net::HTTP.get(URI(get_request)))
			}
			raise "DC API Error: #{response["error"]}" if !(response["nick"] and response["level"])
			if !User.find_by_username(username)
				u = User.create(:username => username, :password => password, :level => response["level"].to_i)
				if response["level"].to_i == 10
					u.is_admin = true
					u.save
				end
			end
		rescue Timeout::Error
			timed_out = true
		rescue Exception => e
			puts e.inspect
		else
		end
		user = User.find_by_username(username)
		if user and user.password == BCrypt::Engine.hash_secret(password, user.salt)
			resp_session = Session.create(:user_id => user.id)
			cookies[:__a] = Base64.encode64 resp_session.token_salt
			cookies[:__b] = Base64.encode64 resp_session.valid_until.to_s
			if flash[:referrer]
				redirect_to flash[:referrer], :notice => "Logged in!"
			else
				redirect_to "/", :notice => "Logged in!"
			end
		else
			flash.keep
			flash[:username] = username
			if !timed_out
				redirect_to "/users/login", :notice => "Username or Password is incorrect. Please contact any DC Admin for the same. If you haven't, please register at <a 					href=\"#{DCHUB_REGISTRATION_LINK}\">#{DCHUB_REGISTRATION_LINK}</a>."
			else
				redirect_to "/users/login", :notice => "Could not connect to DC Hub :("
			end
		end
	end
	
	def killsession
		deleted = Session.where(:token_salt => Base64.decode64(cookies[:__a])).where(:valid_until => Base64.decode64(cookies[:__b])).delete_all
		puts "Delete #{deleted} sessions!"
		cookies.delete :__a
		cookies.delete :__b
		redirect_to "/", :notice => "Logged out!"
	end	
end
