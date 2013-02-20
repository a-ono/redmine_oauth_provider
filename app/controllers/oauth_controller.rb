require 'oauth/controllers/provider_controller'
class OauthController < ApplicationController
  unloadable
  skip_filter :check_if_login_required
  include OAuth::Controllers::ProviderController

  def logged_in?
    User.current.logged?
  end

  def login_required
    raise Unauthorized unless User.current.logged?
  end

  def current_user
    User.current
  end

  protected
  # Override this to match your authorization page form
  # It currently expects a checkbox called authorize
  # def user_authorizes_token?
  #   params[:authorize] == '1'
  # end

  # should authenticate and return a user if valid password.
  # This example should work with most Authlogic or Devise. Uncomment it
  # def authenticate_user(username,password)
  #   user = User.find_by_email params[:username]
  #   if user && user.valid_password?(params[:password])
  #     user
  #   else
  #     nil
  #   end
  # end

end
