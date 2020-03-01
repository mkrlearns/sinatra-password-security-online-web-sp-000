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
	get("/logout") {session.clear; redirect "/"}
	get("/success") {redirect "/login" if !logged_in?; erb :success}
	get("/failure") {erb :failure}

	post "/signup" do
		user = User.new(username: params[:username], password: params[:password])
		redirect "/login" if user.save
		redirect "/failure"
	end

	post "/login" do
		user = User.find_by(username: params[:username])
		if user && user.authenticate(params[:password])
			session[:user_id] = user.id
			redirect "/success"
		end
		redirect "failure"
	end

	helpers do
		def logged_in?() !!session[:user_id] end
		def current_user() User.find(session[:user_id]) end
	end

end
