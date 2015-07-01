# encoding: utf-8
class Card::OrganizersController < Card::BaseController
  before_action :set_organizer, only: [:show, :edit, :update, :destroy]
  # skip_before_action :role_user!
  #列出会展
  def index
    @organizers = Organizer.all.page(params[:page])
  end

  #新建会展 new，create
  def new
    @expos = Expo.all.select {|e| e.organizer == nil}
    @organizer = Organizer.new
    @organizer.build_user
  end

  def show
  end

  def create
    @expos = Expo.all.select {|e| e.organizer == nil}
    @organizer = Organizer.new(organizer_params)
    @organizer.user.password = "111111"
    @organizer.user.role = Role.find_by(name: "organizer")
    @organizer.user.type = "organizer"
    if @organizer.user.invalid? || @organizer.invalid?
      render :new
    else
      @organizer.save
      flash[:notcie] = "新建成功"
      redirect_to card_organizers_path
    end
  end

  #更新会展 edit，update
  def edit
    @expos = Expo.all.select {|e| e.organizer == nil or e.organizer == @organizer}
  end

  def update
    @expos = Expo.all.select {|e| e.organizer == nil or e.organizer == @organizer}
    if @organizer.update(organizer_params)
      flash[:notice] = "更新成功"
      redirect_to :action => 'index'
    else
      flash[:error] = "更新失败"
      render :edit
    end
  end

  def destroy
    if @organizer.expo.exhibitors.blank?
      if @organizer.destroy
        flash[:notcie] = "删除成功"
      else
        flash[:error] = "删除失败"
      end
    else
      flash[:error] = "删除失败,请先删除主办方建立的参展商"
    end
    redirect_to card_organizers_path
  end

  #配置展会状态，这个与审查有关。只有在某个状态下的，才可以做相关的工作
  def config_status

  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_organizer
    @organizer = Organizer.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def organizer_params
    params[:organizer].permit(:real_name, :company_name, :mobile, :phone, :expo_id, user_attributes: [:username, :email])
  end

  def set_title
    @title = "主办方管理"
  end
end
