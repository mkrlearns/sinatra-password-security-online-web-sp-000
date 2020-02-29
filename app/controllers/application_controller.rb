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

	post("/signup") {user = User.new(:username => params[:username], :password => params[:password])}




	post "/login" do
		#your code here!
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
