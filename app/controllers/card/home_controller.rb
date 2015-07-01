# encoding: utf-8
class Card::HomeController < ApplicationController
  #before_action :set_admin_home, only: [:show, :edit, :update, :destroy]
  #skip_before_action :role_user!
  layout 'back/card'
  # GET /admin/home
  # GET /admin/home.json
  def index
  end

  # GET /admin/home/1
  # GET /admin/home/1.json
  def show
    @card = Card.find params[:id]
    @card_type=@card.card_type
  end

  # GET /admin/home/new
  def new
    @card = Card.find '556d8c1e6d616306b1040000'
    @card_type=@card.card_type
    render 'print_demo',layout: false
  end
  def new_card
    @card=Card.new
    @card_fields=[{name:"name",desc:"desc",type:"String"},{name:"name1",desc:"desc1",type:"File"}]
  end

  # GET /admin/home/1/edit
  def edit
  end

  # POST /admin/home
  # POST /admin/home.json
  def create
    @admin_home = Card::Home.new(admin_home_params)

    respond_to do |format|
      if @admin_home.save
        format.html { redirect_to @admin_home, notice: 'Home was successfully created.' }
        format.json { render :show, status: :created, location: @admin_home }
      else
        format.html { render :new }
        format.json { render json: @admin_home.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/home/1
  # PATCH/PUT /admin/home/1.json
  def update
    respond_to do |format|
      if @admin_home.update(admin_home_params)
        format.html { redirect_to @admin_home, notice: 'Home was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin_home }
      else
        format.html { render :edit }
        format.json { render json: @admin_home.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/home/1
  # DELETE /admin/home/1.json
  def destroy
    @admin_home.destroy
    respond_to do |format|
      format.html { redirect_to admin_homes_url, notice: 'Home was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_admin_home
    @admin_home = Card::Home.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def admin_home_params
    params[:admin_home]
  end
end
