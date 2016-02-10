module ApplicationHelper

	def gravatar(user)
		gravatar_id = Digest::MD5::hexdigest(user.email).downcase
		if user.image
			user.image
		else
		"https://gravatar.com/avatar/#{gravatar_id}.jpg?d=identical&s=150"
		end
	end
end
