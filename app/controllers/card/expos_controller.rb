# encoding: utf-8
class Card::ExposController < Card::BaseController
  before_action :set_card_expo, only: [:show, :edit, :update, :destroy, :active]
  # skip_before_action :role_user!
  #列出会展
  def index
    @expos = Expo.all.page(params[:page])
  end

  #新建会展 new，create
  def new
    @expo = Expo.new
    #@checkbox_array = CardType.checkbox_collection
  end

  def show
  end

  def create
    @expo = Expo.create expo_params
    if @expo
      flash[:notcie] = "新建成功"
      redirect_to card_expos_path
    else
      render :new
    end
  end

  #更新会展 edit，update
  def edit
  end

  def update
    @expo = @expo.update(expo_params)
    if @expo
      flash[:notice] = "更新成功"
    else
      flash[:error] = "更新失败"
    end
    redirect_to :action => 'index'
  end

  def destroy
    if @expo.organizer.blank?
      if @expo.destroy
        flash[:notcie] = "删除成功"
      else
        flash[:notcie] = "删除失败"
      end
    else
      flash[:error] = "删除失败,展会下有主办方无法删除，请先删除主办方"
    end
    redirect_to card_expos_path
  end

  #配置展会状态，这个与审查有关。只有在某个状态下的，才可以做相关的工作
  def active
    if @expo.alived?
      flash[:notice] = "已经设置为默认"
    else
      Expo.active.update(alive: false)
      @expo.update(alive: true)
      flash[:notice] = "状态设置成功"
    end
    redirect_to card_expos_path
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_card_expo
    @expo = Expo.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def expo_params
    params[:expo].permit(:name, :desc, card_type_ids: [])
  end

  def set_title
    @title = "展会管理"
  end
end
