class UsersController < ApplicationController
  
  def login
    @title = "Sign-in"
    if request.post?
      u = User.find(:first, :conditions => ["emailaddress ILIKE :emailaddress AND password = :password", {:emailaddress => params[:user][:emailaddress], :password => Digest::MD5.hexdigest(params[:user][:password])}])
      if u.class == User
        set_current_user(u)
        if session[:redirect]
          redirect_to(session[:redirect])
        else
          redirect_to url_for :controller => :home, :action => :home
        end
        session[:redirect] = nil
      else
        flash[:error] = "Unable to login"
      end
    end
  end
  
  def logout
    @title = "Sign Out"
    clear_current_user
  end
  
end
