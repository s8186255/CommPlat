# encoding: utf-8
class Card::CheckController < Card::BaseController
  # before_action :set_admin_home, only: [:show, :edit, :update, :destroy]
  # skip_before_action :role_user!
  #before_action :set_expo,  only: [:show_exhibitor, :show_card, :exhibitors, :exhibitor_is_not_ok, :exhibitor_is_ok, :card_is_ok, :card_is_not_ok, :cards]

  #审核参展商信息

  # 弃用 信息管理员审核参展商
  #待审核参展商列表
  def exhibitors
    if params[:expo_id].blank?
      @exhibitors = Exhibitor.all.apply.page(params[:page])
    else
      @exhibitors = Expo.find(:expo_id).exhibitors.apply.page(params[:page])
    end
  end

  # 弃用 信息管理员审核参展商
  def show_exhibitor
    @exhibitor = @expo.exhibitors.find(params[:id])
    @card_types = @expo.card_types

  end

  # 弃用 信息管理员审核参展商
  def exhibitor_is_ok
    @exhibitor = @expo.exhibitors.apply.find(params[:id])
    if @exhibitor.update(status: 2)
      # 解锁用户
      @exhibitor.user.unlock_access!
      flash[:notice] = "审核通过"
    else
      flash[:error] = "审核失败"
    end
    redirect_to exhibitors_card_check_index_path
  end

  # 弃用 信息管理员审核参展商
  #审核之后不通过,并发送消息，check_message
  def exhibitor_is_not_ok
    @exhibitor = @expo.exhibitors.apply.find(params[:id])
    if @exhibitor.update(status: -1, error_msg: params[:msg])
      flash[:notice] = "审核不通过"
    else
      flash[:error] = "审核失败"
    end
    redirect_to exhibitors_card_check_index_path

  end
  #审核办卡信息
  #卡列表
  def cards
    @expos = Expo.all
    if params[:expo_id].blank?
      @cards = Card.apply.page(params[:page])
    else
      @cards = Expo.find(params[:expo_id]).cards.apply.page(params[:page])
    end
  end

  def show_card
    @card = Card.find(params[:id])
    @card_types = @card.expo.card_types
    @card_fields =Settings.applicant_type[@card.card_type.applicant_type]
  end
  #审核通过某卡
  def card_is_ok
    @card = Card.find(params[:id])
    if @card.update(status: 2)
      flash[:notice] = "审核通过"
    else
      flash[:error] = "审核失败"
    end
    redirect_to cards_card_check_index_path(expo_id: params[:expo_id])

  end
  #审核某卡之后，不通过,并发送消息，check_message
  def card_is_not_ok
    @card = Card.find(params[:id])
    if @card.update(status: -1, message: params[:msg])
      flash[:notice] = "审核不通过"
    else
      flash[:error] = "审核失败"
    end
    redirect_to cards_card_check_index_path(expo_id: params[:expo_id])
  end

  #核实某参展商的制卡费用
  #参展商，带有费用的列表
  #待审核参展商列表
  def exhibitor_fee_list
    @payments = @expo.payments.where(is_accountant_check: false )

  end
  #审核通过某参展商
  def exhibitor_fee_is_ok

  end
  #审核之后不通过,并发送消息，check_message
  def exhibitor_fee_is_not_ok

  end

  #财务审核
  #待审核参展商列表
  def exhibitor_finance_list

  end
  #审核通过某参展商
  def exhibitor_finance_is_ok

  end
  #审核之后不通过,并发送消息，check_message
  def exhibitor_finance_is_not_ok

  end



  #审核办卡信息
  #卡列表
  def self_apply_cards
    @expos = Expo.all
    if params[:expo_id].blank?
      @self_apply_cards = SelfApplyCard.apply.page(params[:page])
    else
      @self_apply_cards = Expo.find(params[:expo_id]).self_apply_cards.apply.page(params[:page])
    end
  end

  def show_self_apply_card
    @self_apply_card = SelfApplyCard.find(params[:id])
    #@expo = Expo.find(params[:expo_id])
    @card_type = CardType.find_by id: Settings.card_type.professional_vistor_id
    @card_fields =Settings.applicant_type[@card_type.applicant_type]
  end
  #审核通过某卡
  def self_apply_card_is_ok
    @self_apply_card = SelfApplyCard.find(params[:id])
    if @self_apply_card.update(status: 2)
      #TODO  短信发送
      flash[:notice] = "审核通过"
    else
      flash[:error] = "审核失败"
    end
    redirect_to self_apply_cards_card_check_index_path(expo_id: params[:expo_id])
  end

  #审核某卡之后，不通过,并发送消息，check_message
  def self_apply_card_is_not_ok
    @self_apply_card = SelfApplyCard.find(params[:id])
    if @self_apply_card.update(status: -1, message: params[:msg])
      #TODO  短信发送
      flash[:notice] = "审核不通过"
    else
      flash[:error] = "审核失败"
    end
    redirect_to self_apply_cards_card_check_index_path(expo_id: params[:expo_id])
  end

  private

  def set_title
    @title = "审核管理"
  end

end
