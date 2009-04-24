# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  audit User, Photo, Image, Album, Geotag

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  #protect_from_forgery # :secret => 'a6dadfb86cdba17446a85c5dec78120b'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password
  
  # Rather than using session[:user], this site uses current_user, only setting
  # session[:user_id] via the set_current_user method below.  The first time
  # during a request that we need the user object, we'll grab it from the db,
  # and cache it in the class variable
  def logged_in?
    current_user ? true : false;
  end
  helper_method :logged_in?
  
  def current_user
    @current_user ||= (session[:user_id] ? User.find_by_id(session[:user_id]) : nil)
  end
  helper_method :current_user
  
  def set_current_user(user_or_id)
    if user_or_id.is_a?(User)
      @current_user = user_or_id
      session[:user_id] = current_user.id
    elsif user_or_id.is_a?(Fixnum)
      session[:user_id] = user_or_id
    else
      raise 'Failed to set current user - unknown type given'
    end
  end
  
  def clear_current_user
    session[:user_id] = nil
  end
  
  def login_required
    unless logged_in?
      session[:redirect] = request.request_uri
      redirect_to url_for(:controller => :users, :action => :login)
    end
  end

  def set_title(title)
    @title = title
  end
  
end
