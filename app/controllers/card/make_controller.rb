# encoding: utf-8
require 'csv'
class Card::MakeController < Card::BaseController
  # before_action :set_admin_home, only: [:show, :edit, :update, :destroy]
  # skip_before_action :role_user!

  # 待制卡列表
  def index
    @cards=Card.where(status: 2).page(params[:page])
    @cards=@cards.where(card_type_id: params[:card_type_id]) unless params[:card_type_id].blank?
    @cards=@cards.where(expo_id: params[:expo_id]) unless params[:expo_id].blank?
    @card_types = CardType.all
    @expos = Expo.all
  end

  #专业观众待制卡
  def self_index
    @self_apply_cards = SelfApplyCard.where(status: 2).page(params[:page])
    @self_apply_cards = @self_apply_cards.where(expo_id: params[:expo_id]) unless params[:expo_id].blank?
    @expos = Expo.all
  end

  # 已制卡列表
  def index_printed
    @cards=Card.where(status: 3).page(params[:page])
    @cards=@cards.where(card_type_id: params[:card_type_id]) unless params[:card_type_id].blank?
    @cards=@cards.where(expo_id: params[:expo_id]) unless params[:expo_id].blank?
    @card_types = CardType.all
    @expos = Expo.all
  end

  # 专业观众已制卡列表
  def self_index_printed
    @self_apply_cards=SelfApplyCard.where(status: 3).page(params[:page])
    @self_apply_cards=@self_apply_cards.where(expo_id: params[:expo_id]) unless params[:expo_id].blank?
    @expos = Expo.all
  end

  def dl
    if params[:card_type_id].blank?
      flash[:error] = "请先选择卡证类型"
      redirect_to card_make_index_path
      return
    end
    @cards=Card.where(status: 2, card_type_id: params[:card_type_id]).page(params[:page])
    @cards=@cards.where(expo_id: params[:expo_id]) unless params[:expo_id].blank?
    #@cards=@cards.where(card_type_id: params[:card_type_id]) unless params[:card_type_id].blank?
    images_name = "20150626001"
    photo_files = []
    @cards.each do |card|
      photo_files << card["photo"]
    end
    @cards.update_all(status: 3)
    p "--" * 20
    p `cd public/uploads/images && tar -czvf #{images_name}.tar.gz #{photo_files.join(' ')}`
    file_path = "public/uploads/images/#{images_name}.tar.gz"
    send_file file_path,:disposition => 'inline'
  end

  def export
    if params[:card_type_id].blank?
      flash[:error] = "请先选择卡证类型"
      redirect_to card_make_index_path
      return
    end
    @cards=Card.where(status: 2, card_type_id: params[:card_type_id])
    @cards=@cards.where(expo_id: params[:expo_id]) unless params[:expo_id].blank?
    #@cards=@cards.where(card_type_id: params[:card_type_id]) unless params[:card_type_id].blank?
    @card_type = CardType.find(params[:card_type_id])
    @card_fields =Settings.applicant_type[@card_type.applicant_type]
    respond_to do |format|
      format.xls
    end
  end
  #专业观众导出
  def self_export
    @self_apply_cards=SelfApplyCard.where(status: 2, card_type_id: Settings.card_type.professional_vistor_id)
    @self_apply_cards=@self_apply_cards.where(expo_id: params[:expo_id]) unless params[:expo_id].blank?
    #@self_apply_cards=@self_apply_cards.where(card_type_id: params[:card_type_id]) unless params[:card_type_id].blank?
    @card_type = CardType.find(Settings.card_type.professional_vistor_id)
    @card_fields =Settings.applicant_type[@card_type.applicant_type]
    respond_to do |format|
      format.xls
    end
  end

  #预览
  def preview
    @card = Card.find(params[:id])
    render layout: false
  end
  def print
    @card = Card.find(params[:id])
    @card.update(status: 3)
    flash[:notice] = "制卡完毕"
    redirect_to card_make_index_path
  end

  def self_print
    @self_apply_card = SelfApplyCard.find(params[:id])
    @self_apply_card.update(status: 3)
    flash[:notice] = "制卡完毕"
    redirect_to self_index_card_make_index_path
  end

  #打印
  def print_list
    if params[:card_type_id].blank?
      @cards=Card.where(status: 2).page(params[:page])
    else
      @cards=Card.where(status: 2, card_type_id: params[:card_type_id]).page(params[:page])
    end
    render layout: false
  end


  private
  def set_title
    @title = "制卡管理"
  end

end
