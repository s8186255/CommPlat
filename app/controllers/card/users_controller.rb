# encoding: utf-8
class Card::CheckController <  Card::BaseController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /admin/users
  # GET /admin/users.json
  def index
    user_type = params[:user_type]
    if user_type
      @users = User.includes(:role).filter_type(user_type).page(params[:page])
    else
      @users = User.includes(:role).page(params[:page])
    end
  end

  # GET /admin/users/1
  # GET /admin/users/1.json
  def show
  end

  # GET /admin/users/new
  def new
    @user = User.new
  end

  # GET /admin/users/1/edit
  def edit
  end

  # POST /admin/users
  # POST /admin/users.json
  def create
    @user = User.new(user_params)
    @user.type = @user.role.name
    respond_to do |format|
      if @user.save
        format.html { redirect_to admin_users_path, notice: '创建用户成功' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/users/1
  # PATCH/PUT /admin/users/1.json
  def update
    respond_to do |format|
      if params[:user][:password].blank?
        params[:user].delete(:password)
        params[:user].delete(:password_confirmation)
      end
      if @user.update(user_params)
        format.html { redirect_to admin_users_path, notice: '更新用户信息成功' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/users/1
  # DELETE /admin/users/1.json
  def destroy
    if @user.access_locked?
      @user.unlock_access!
    else
      @user.locked_at= Time.now
      @user.save
    end
    respond_to do |format|
      format.html { redirect_to admin_users_path, notice: '修改账号状态成功' }
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
    params[:user].permit(:password, :role_id, :email, :username)
  end

  def set_title
    @title = "用户信息维护"
  end
end
