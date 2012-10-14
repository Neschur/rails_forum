module ApplicationHelper
	def isadmin
		if !User.exists?(session[:user_id])
			session[:user_id]=nil
		end
		true if session[:user_id] && User.find(session[:user_id]).is_admin
	end

	def logged
		session[:user_id]
	end

	def to_date ar_datetime
		ar_datetime.to_datetime.to_s.scan(/[\d-]+/)[0]
	end

	def imgurl user
		return user.avatar.url if user.avatar.url
		return '/ava.png'
	end

	def hpe post
		true if isadmin || post.user_id==session[:user_id];
	end

	def show_user_login user
		return user.login if user
		'USER REMOVED'
	end
end
