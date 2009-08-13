class UsersController < ApplicationController
  before_filter :find_user, :only => [:update, :show]
  before_filter :admin_required, :only => [:update, :update]
  
  
  def index
    @users = User.find(:all, :order=>"created_at DESC")
  end
  
  def show
  end
  
  def new
    @user = User.new
  end
  
  def create
    logout_keeping_session!
    @user = User.new(params[:user])
    success = @user && @user.save
    if success && @user.errors.empty?
      # Protects against session fixation attacks, causes request forgery
      # protection if visitor resubmits an earlier form using back
      # button. Uncomment if you understand the tradeoffs.
      # reset session
      self.current_user = @user # !! now logged in
      redirect_back_or_default('/')
      flash[:notice] = "Thanks for signing up!"
    else
      flash[:error]  = "We couldn't set up that account, sorry.  Please try again, or contact us (link is above)."
      render :action => 'new'
    end
  end
  
    # PUT /users/1
  # PUT /users/1.xml
  def update
    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:notice] = 'User was successfully updated.'
        format.html { redirect_to(@user) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  protected
  def find_user
    @user = User.find_by_login(params[:id])
  end
  
end
