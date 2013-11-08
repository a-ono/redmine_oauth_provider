class OauthClientsController < ApplicationController
  unloadable

  before_filter :require_admin
  before_filter :find_client_application, :only => [:show, :edit, :update, :destroy]

  def index
    @client_applications = ClientApplication.all
  end

  def new
    @client_application = ClientApplication.new
  end

  def create
    @client_application = ClientApplication.new(params[:client_application])
    if @client_application.save
      flash[:notice] = "Registered the information successfully"
      redirect_to :action => "show", :id => @client_application.id
    else
      render :action => "new"
    end
  end

  def show
  end

  def edit
  end

  def update
    if @client_application.update_attributes(params[:client_application])
      flash[:notice] = "Updated the client information successfully"
      redirect_to :action => "show", :id => @client_application.id
    else
      render :action => "edit"
    end
  end

  def destroy
    @client_application.destroy
    flash[:notice] = "Destroyed the client application registration"
    redirect_to :action => "index"
  end

  private
  def find_client_application
    @client_application = ClientApplication.find(params[:id])
  end
end
