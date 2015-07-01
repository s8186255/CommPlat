# encoding: utf-8
class Card::CardsController < Card::BaseController
  before_action :set_card, only: [:show, :edit, :update, :destroy]
  #skip_before_action :role_user!

  # for exhibitor人员信息上传 new，create
  def index
    if params[:commit].blank?
      @cards = current_user.exhibitor.cards.where(:status.in => [-1,0]).page(params[:page])
    else
      @cards = current_user.exhibitor.cards.where(:status.gt => 0).page(params[:page])
    end
  end

  def show
    @card_type = @card.card_type
    @card_fields =Settings.applicant_type[@card_type.applicant_type]
  end

  #新建会展 new，create
  #def new
  #@step = params[:step]
  #@card = current_user.exhibitor.cards.build
  #@expo = Expo.active.first
  #@card_types = @expo.card_types
  #if @step == "2"
  #@card_type = @expo.card_types.find(params[:card_type_id])
  #@card_fields =Settings.applicant_type[@card_type.applicant_type]
  #end
  #end

  #def create
  ##@card_types = current_user.exhibitor.expo.card_types
  #@card = current_user.exhibitor.cards.build(card_params)
  #@card_type = @card.card_type
  #@card_fields =Settings.applicant_type[@card_type.applicant_type]
  #@card.expo = Expo.active.first
  #if @card.save
  #flash[:notcie] = "新建成功"
  #redirect_to card_cards_path
  #else
  #@step == "2"
  #flash[:notcie] = "新建失败"
  #render :new
  #end
  #end

  #更新会展 edit，update
  def edit
    if @card.status > 0
      flash[:error] = "已经上报完成，无需重复上报！"
      redirect_to :action => 'index'
      return
    end
    @card_type = @card.card_type
    @card_fields =Settings.applicant_type[@card_type.applicant_type]
  end

  def update
    card = @card.update(card_params)
    if card
      flash[:notice] = "恭喜你上报完成，请耐心等待审核制卡"
      redirect_to :action => 'index'
    else
      flash[:error] = "上报出错"
      @card_type = @card.card_type
      @card_fields =Settings.applicant_type[@card_type.applicant_type]
      render :edit
    end
  end

  def destroy
    if @card.destroy
      flash[:notcie] = "删除成功"
    else
      flash[:notcie] = "删除失败"
    end
    redirect_to card_cards_path
  end

  #配置展会状态，这个与审查有关。只有在某个状态下的，才可以做相关的工作
  def config_status

  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_card
    @card = current_user.exhibitor.cards.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def card_params
    params[:card].permit(:area, :other_card, :name, :en_name, :birth, :gender, :phone, :email, :job_title, :country, :province, :city, :inhabit_address, :work_unit_abbr, :work_unit, :work_branch, :id_card, :id_card_expiry_date, :passport, :passport_expiry_date, :booth_no, :vehicle_type, :vehicle_no, :type, :photo, :id_type )
  end

  def set_title
    @title = "卡证信息管理"
  end
end
