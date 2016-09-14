module ApplicationHelper
	class CodeRayify < Redcarpet::Render::HTML
		def block_code(code, language)
			CodeRay.scan(code, language ? language : :plaintext).div
		end
	end
	
	def markdown(text)
		if !@markdown
			@coderayified = CodeRayify.new(
				autolink:				 true,
				filter_html:     false,
				hard_wrap:       true, 
				link_attributes: { rel: 'nofollow', target: "_blank" },
				space_after_headers: true, 
			)
			extensions = {
				fenced_code_blocks: true,
				no_intra_emphasis: 	true,
				autolink: 					true,
				strikethrough: 			true,
				lax_html_blocks: 		true,
				superscript: 				false,
				autolink:           true,
				disable_indented_code_blocks: true
			}
			@markdown = Redcarpet::Markdown.new(@coderayified, extensions)
		end
		text = @markdown.render(text).html_safe
		return text
#		return Regexp.new('^<p>(.*)<\/p>$').match(text)[1] rescue text
#		return Regexp.new(/\A<p>(.*)<\/p>\Z/m).match(text)[1] rescue text	
	end
		
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
