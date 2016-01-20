require 'oauth/controllers/provider_controller'
class OauthController < ApplicationController
  unloadable
  skip_filter :check_if_login_required
  include OAuth::Controllers::ProviderController

  before_filter :login_or_oauth_required, :only => [:user_info]

  def logged_in?
    User.current.logged?
  end

  def login_required
    raise Unauthorized unless User.current.logged?
  end

  def user_info
    respond_to do |format|
      format.json { render :json => User.current.to_json(only: [:login, :firstname, :lastname], methods: [:mail]) }
    end
  end

  def current_user
    User.current
  end

  def current_user=(user)
    self.logged_user = user
  end

  protected
  def user_authorizes_token?
    params[:allow]
  end
end
