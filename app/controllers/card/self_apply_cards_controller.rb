# encoding: utf-8
class Card::SelfApplyCardsController < Card::BaseController
  #layout 'back/card'
  #before_action :set_professional_vistor, only: [:show, :edit, :update, :destroy]
  # skip_before_action :role_user!
  skip_before_action :authenticate_user!
  layout 'back/pv'

  #新建会展 new ， create

  def new
    @step = params[:step]
    @self_apply_card = SelfApplyCard.new
    @expos = Expo.all
    if @step == "2"
      @card_type = CardType.find_by id: Settings.card_type.professional_vistor_id
      @expo = Expo.find(params[:expo_id])
      @card_fields =Settings.applicant_type[@card_type.applicant_type]
    end
  end

  def create
    #@card_types = current_user.exhibitor.expo.card_types
    @expo = Expo.find(params[:self_apply_card][:expo_id])
    #@expo = Expo.find(params[:expo_id])
    #if @expo.nil?
    #end
    @self_apply_card = SelfApplyCard.new(card_params)
    @card_type = @self_apply_card.card_type
    @card_fields = Settings.applicant_type[@card_type.applicant_type]
    if @self_apply_card.save
      flash[:notcie] = "提交成功"
      redirect_to card_self_apply_card_path(@self_apply_card)
    else
      @step == "2"
      flash[:notcie] = "新建失败"
      p @self_apply_card.errors.full_messages
      render :new
    end
  end

  def show
  end


  private
  def set_card
    @self_apply_card = SelfApplyCard.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def card_params
    params[:self_apply_card].permit(:sn, :expo_id, :card_type_id, :name, :en_name, :birth, :gender, :phone, :email, :job_title, :country, :province, :city, :inhabit_address, :work_unit_abbr, :work_unit, :work_branch, :id_card, :id_card_expiry_date, :passport, :passport_expiry_date, :booth_no, :vehicle_type, :vehicle_no, :type, :photo, :id_type )
  end

  def set_title
    @title = "专业观众卡证办理"
  end
end
