class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def logged_in?
    !!current_user
  end

  def current_user
    user = User.find_by_session_token(session[:session_token])
    return nil if user.nil?
    user
  end

  def log_in!(user)
    session[:session_token] = user.session_token
  end

  def log_out!(user)
    user.reset_session_token
    session[:session_token] = nil
  end



end
