class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    if !user_signed_in?
      redirect_to(unauthenticated_root_path)
    else
      @users = User.all
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    if !user_signed_in?
      redirect_to(unauthenticated_root_path)
    end
  end

  # GET /users/new
  def new
    if !user_signed_in?
      redirect_to(unauthenticated_root_path)
    else
      @user = User.new
    end
  end

  # GET /users/1/edit
  def edit
    if !user_signed_in?
      redirect_to(unauthenticated_root_path)
    end
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    @user.skip_confirmation!
    respond_to do |format|
      if @user.save
        if params[:is_admin].present?
          @user.add_role :admin
        end
        if params[:user][:avatar].present?
          user.avatar.attach(params[:user][:avatar])
        end
        format.html { redirect_to users_path, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update_without_password(user_params)
        if params[:is_admin].present? && !@user.has_role?(:admin)
          @user.add_role :admin
        elsif !params[:is_admin].present? && @user.has_role?(:admin)
          @user.remove_role :admin
        end
        if params[:user][:avatar].present?
          user.avatar.attach(params[:user][:avatar])
        end
        format.html { redirect_to users_path, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully removed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params[:user][:ro] = params[:ro].present?
      params[:user][:cs] = params[:cs].present?
      params.require(:user).permit(:first_name, :last_name, :email, :password, :ro, :cs)
    end
end
