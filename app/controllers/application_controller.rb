require "./config/environment"
require "./app/models/user"
class ApplicationController < Sinatra::Base

	configure do
		set :views, "app/views"
		enable :sessions
		set :session_secret, "password_security"
	end

	get("/") {erb :index}
	get("/signup") {erb :signup}
	get("/login") {erb :login}
	get("/success") {logged_in? ? erb :success : redirect "/login"}
	get("/failure") {erb :failure}
	get("/logout") {session.clear; redirect "/"}

	post "/signup" do
		user = User.new(username: params[:username], password: params[:password])
	  if user.save
			redirect "/login"
		end
		redirect "/failure"
	end

	post "/login" do
	  user = User.find_by(username: params[:username])
	  if user
			session[:user_id] = user.id
			redirect "/success"
		end
	  redirect "/failure"
	end

	# get "/success" do
	# 	if logged_in?
	# 		erb :success
	# 	else
	# 		redirect "/login"
	# 	end
	# end

	helpers do
		def logged_in?() !!session[:id] end
		def current_user() User.find(session[:id]) end
	end

end
