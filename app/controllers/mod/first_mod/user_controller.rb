class Mod::FirstMod::UserController < ApplicationController
  before_action :set_mod_first_mod_user, only: [:show, :edit, :update, :destroy]

  # GET /mod/first_mod/users
  # GET /mod/first_mod/users.json
  def index
    @mod_first_mod_users = Mod::FirstMod::User.all
  end

  # GET /mod/first_mod/users/1
  # GET /mod/first_mod/users/1.json
  def show
  end

  # GET /mod/first_mod/users/new
  def new
    @mod_first_mod_user = Mod::FirstMod::User.new
  end

  # GET /mod/first_mod/users/1/edit
  def edit
  end

  # POST /mod/first_mod/users
  # POST /mod/first_mod/users.json
  def create
    @mod_first_mod_user = Mod::FirstMod::User.new(mod_first_mod_user_params)

    respond_to do |format|
      if @mod_first_mod_user.save
        format.html { redirect_to @mod_first_mod_user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @mod_first_mod_user }
      else
        format.html { render :new }
        format.json { render json: @mod_first_mod_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /mod/first_mod/users/1
  # PATCH/PUT /mod/first_mod/users/1.json
  def update
    respond_to do |format|
      if @mod_first_mod_user.update(mod_first_mod_user_params)
        format.html { redirect_to @mod_first_mod_user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @mod_first_mod_user }
      else
        format.html { render :edit }
        format.json { render json: @mod_first_mod_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mod/first_mod/users/1
  # DELETE /mod/first_mod/users/1.json
  def destroy
    @mod_first_mod_user.destroy
    respond_to do |format|
      format.html { redirect_to mod_first_mod_users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mod_first_mod_user
      @mod_first_mod_user = Mod::FirstMod::User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def mod_first_mod_user_params
      params[:mod_first_mod_user]
    end
end
