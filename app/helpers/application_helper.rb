module ApplicationHelper

	def gravatar_url(user)
		gravatar_id = Digest::MD5::hexdigest(user.email).downcase
		if user.image
			user.image
		else
		"https://www.gravatar.com/avatar/#{gravatar_id}"
		end
	end
end
