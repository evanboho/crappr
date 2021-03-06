class UsersController < ApplicationController
  # GET /users
  # GET /users.json
  #before_filter :signed_in?, :only => [:index, :edit, :show, :update, :destroy]
  before_filter :authenticate_user!, :only => [:index, :edit, :show, :update, :destroy]
  before_filter :current_user?, :only => [:edit, :update, :destroy]
  
  def current_user?
    @user = User.find(params[:id])
    if @user != current_user
      redirect_to users_path, :notice => "you may not access that crap"
    end
  end
  
  def index
    @users = User.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in_and_redirect_to user_profile_path, notice: 'User was successfully created.'
    else
      redirect_to new_user_registration_url
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    # respond_to do |format|
      if @user.update_attributes(params[:user])
        redirect_to @user
        #format.html { redirect_to sign_in(@user), notice: 'User was successfully updated.' }
        # format.json { head :no_content }
      #else
       # format.html { render action: "edit" }
        # format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    #end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end
end
