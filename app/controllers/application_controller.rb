class ApplicationController < ActionController::Base
  protect_from_forgery
  
  protected
    def authenticate
      true
    end
    
    def logged_out
    end
end
