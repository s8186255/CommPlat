class Mod::FirstMod::AdminController < ApplicationController
  before_action :set_mod_first_mod_admin, only: [:show, :edit, :update, :destroy]

  # GET /mod/first_mod/admins
  # GET /mod/first_mod/admins.json
  def index
    @mod_first_mod_admins = Mod::FirstMod::Admin.all
  end

  # GET /mod/first_mod/admins/1
  # GET /mod/first_mod/admins/1.json
  def show
  end

  # GET /mod/first_mod/admins/new
  def new
    @mod_first_mod_admin = Mod::FirstMod::Admin.new
  end

  # GET /mod/first_mod/admins/1/edit
  def edit
  end

  # POST /mod/first_mod/admins
  # POST /mod/first_mod/admins.json
  def create
    @mod_first_mod_admin = Mod::FirstMod::Admin.new(mod_first_mod_admin_params)

    respond_to do |format|
      if @mod_first_mod_admin.save
        format.html { redirect_to @mod_first_mod_admin, notice: 'Admin was successfully created.' }
        format.json { render :show, status: :created, location: @mod_first_mod_admin }
      else
        format.html { render :new }
        format.json { render json: @mod_first_mod_admin.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /mod/first_mod/admins/1
  # PATCH/PUT /mod/first_mod/admins/1.json
  def update
    respond_to do |format|
      if @mod_first_mod_admin.update(mod_first_mod_admin_params)
        format.html { redirect_to @mod_first_mod_admin, notice: 'Admin was successfully updated.' }
        format.json { render :show, status: :ok, location: @mod_first_mod_admin }
      else
        format.html { render :edit }
        format.json { render json: @mod_first_mod_admin.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mod/first_mod/admins/1
  # DELETE /mod/first_mod/admins/1.json
  def destroy
    @mod_first_mod_admin.destroy
    respond_to do |format|
      format.html { redirect_to mod_first_mod_admins_url, notice: 'Admin was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mod_first_mod_admin
      @mod_first_mod_admin = Mod::FirstMod::Admin.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def mod_first_mod_admin_params
      params[:mod_first_mod_admin]
    end
end
