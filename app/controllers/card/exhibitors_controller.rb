# encoding: utf-8
class Card::ExhibitorsController < Card::BaseController
  before_action :set_exhibitor, only: [:show, :edit, :update, :destroy]
  # skip_before_action :role_user!
  #列出会展
  def index
    @exhibitors = current_user.organizer.expo.exhibitors.page(params[:page])
  end

  #新建会展 new，create
  def new
    @exhibitor = current_user.organizer.expo.exhibitors.build
    @exhibitor.build_user
    @card_types = current_user.organizer.expo.card_types
  end

  def show
    @card_types = current_user.organizer.expo.card_types
  end

  def create
    @expo = current_user.organizer.expo
    @card_types = @expo.card_types
    @exhibitor = @expo.exhibitors.build(exhibitor_params)
    @exhibitor.user.password = "111111"
    # 锁定状态 通过审核后方可登陆
    @exhibitor.user.role = Role.find_by(name: "exhibitor")
    @exhibitor.user.type = "exhibitor"
    if @exhibitor.user.invalid? || @exhibitor.invalid?
      render :new
    else
      @exhibitor.user.lock_access!
      @exhibitor.save
      #card_types 张数确认
      @card_types.each do |card_type|
        num = params[card_type.id.to_s].to_i
        num.times do
          card = @exhibitor.cards.create(expo_id: @expo.id, card_type_id: card_type.id)
          p card
        end
      end
      flash[:notcie] = "新建成功,等待审核"
      redirect_to card_exhibitors_path
    end
  end

  #更新会展 edit，update
  def edit
    unless @exhibitor.user.access_locked?

      flash[:error] = "已经审核无法修改"
      redirect_to card_exhibitors_path
      return
    end
    @card_types = current_user.organizer.expo.card_types

  end

  def update
    @exhibitor.cards.delete_all
    @expo = current_user.organizer.expo
    @card_types = @expo.card_types
    @exhibitor.update(exhibitor_params)
    if @exhibitor.status == -1
      @exhibitor.update(status: 0)
    end
    @card_types.each do |card_type|
      num = params[card_type.id.to_s].to_i
      p num.to_s + " -====" + card_type.id
      if num > 0
        num.times { @exhibitor.cards.create(expo_id: @expo.id, card_type_id: card_type.id) }
      end
    end
    @exhibitor.save
    if @exhibitor
      flash[:notice] = "更新成功"
    else
      flash[:error] = "更新失败"
    end
    redirect_to :action => 'index'
  end

  def destroy
    if @exhibitor.status == 1
      flash[:error] = "已审核通过,无法删除"
      redirect_to card_exhibitors_path
      return
    end
    if @exhibitor.destroy
      flash[:notcie] = "删除成功"
    else
      flash[:error] = "删除失败"
    end
    redirect_to card_exhibitors_path
  end

  #配置展会状态，这个与审查有关。只有在某个状态下的，才可以做相关的工作
  def config_status

  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_exhibitor
    @exhibitor = current_user.organizer.expo.exhibitors.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def exhibitor_params
    params[:exhibitor].permit(:real_name, :company_name, :mobile, :phone, user_attributes: [:username, :email])
  end

  def set_title
    @title = "参展商管理"
  end
end
