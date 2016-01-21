class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_login_user
  protected
  def set_login_user
    @current_user = User.find_by(id: session[:user_id]) if session[:user_id] #後置のif if以下がtrue→if前をやる
  end
  def login?
    if !session.has_key? :user_id
      return redirect_to sessions_login_path
    end
    if @current_user.nil?
      return redirect_to sessions_login_path
    end
  end
end
