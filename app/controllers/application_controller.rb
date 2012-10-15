class ApplicationController < ActionController::Base
  before_filter :set_credentials
  protect_from_forgery

  protected
  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      username == @username && password == @password && session[:logged_out] != true
    end
    session[:logged_out] = nil
  end

  def logged_out
    session[:logged_out] = true
  end

  private
  def set_credentials
    @username = "teacher"
    @password = "kickin4jesus"
  end
end
