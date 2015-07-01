class Mod::FirstMod::HomeController < ApplicationController
  before_action :set_mod_first_mod_home, only: [:show, :edit, :update, :destroy]

  # GET /mod/first_mod/homes
  # GET /mod/first_mod/homes.json
  def index
    @mod_first_mod_homes = Mod::FirstMod::Home.all
  end

  # GET /mod/first_mod/homes/1
  # GET /mod/first_mod/homes/1.json
  def show
  end

  # GET /mod/first_mod/homes/new
  def new
    @mod_first_mod_home = Mod::FirstMod::Home.new
  end

  # GET /mod/first_mod/homes/1/edit
  def edit
  end

  # POST /mod/first_mod/homes
  # POST /mod/first_mod/homes.json
  def create
    @mod_first_mod_home = Mod::FirstMod::Home.new(mod_first_mod_home_params)

    respond_to do |format|
      if @mod_first_mod_home.save
        format.html { redirect_to @mod_first_mod_home, notice: 'Home was successfully created.' }
        format.json { render :show, status: :created, location: @mod_first_mod_home }
      else
        format.html { render :new }
        format.json { render json: @mod_first_mod_home.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /mod/first_mod/homes/1
  # PATCH/PUT /mod/first_mod/homes/1.json
  def update
    respond_to do |format|
      if @mod_first_mod_home.update(mod_first_mod_home_params)
        format.html { redirect_to @mod_first_mod_home, notice: 'Home was successfully updated.' }
        format.json { render :show, status: :ok, location: @mod_first_mod_home }
      else
        format.html { render :edit }
        format.json { render json: @mod_first_mod_home.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mod/first_mod/homes/1
  # DELETE /mod/first_mod/homes/1.json
  def destroy
    @mod_first_mod_home.destroy
    respond_to do |format|
      format.html { redirect_to mod_first_mod_homes_url, notice: 'Home was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mod_first_mod_home
      @mod_first_mod_home = Mod::FirstMod::Home.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def mod_first_mod_home_params
      params[:mod_first_mod_home]
    end
end
