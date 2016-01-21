class UsersController < ApplicationController
  before_action :login?, only: [:edit, :update, :destroy]
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all.order("created_at desc")
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @images = @user.images.all
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    respond_to do |format|
      if @current_user.id != @user.id
        format.html { redirect_to @user, notice: '他のユーザの情報は変更できません.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html{ render :edit }
      end
    end
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
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
      if @current_user.id != @user.id
        format.html { redirect_to @user, notice: '他のユーザの情報は変更できません.' }
        format.json { render :show, status: :created, location: @user }
      else
        if @user.update(user_params)
          format.html { redirect_to @user, notice: 'User was successfully updated.' }
          format.json { render :show, status: :ok, location: @user }
        else
          format.html { render :edit }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end

    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    respond_to do |format|
      if @current_user.id == @user.id
        @user.destroy
        format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
        format.json { head :no_content }
      else
        format.html { redirect_to @user, notice: '他のユーザを削除することは変更できません.' }
        format.json { render :show, status: :created, location: @user }
      end

    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :password, :password_confirmation)
    end
end
