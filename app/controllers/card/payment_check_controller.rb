# encoding: utf-8
class Card::PaymentCheckController < Card::BaseController
  # before_action :set_admin_home, only: [:show, :edit, :update, :destroy]
  # skip_before_action :role_user!
  before_action :set_expo


  #核实某参展商的制卡费用
  #参展商，带有费用的列表
  #待审核参展商列表
  def exhibitors
    if params[:check].blank?
      @exhibitors = @expo.exhibitors.where(status: 0).page(params[:id])
    else
      @exhibitors = @expo.exhibitors.where(:status.gt => 0).page(params[:id])
    end
    @card_types = @expo.card_types
    @expos = Expo.all
  end

  def unchecked_card_count
    @expos = Expo.all
    respond_to do |f|
      f.json
    end
    #render json: [{id: "558d133b695a3236d2580000", name: "主办方1", num: 2}, {name: "主办方2", num: 3}, {name: "主办方5", num: 7}]
  end
  #审核通过某参展商
  def exhibitor_fee_is_ok

  end
  #审核之后不通过,并发送消息，check_message
  def exhibitor_fee_is_not_ok

  end

  #财务审核
  #待审核参展商列表
  def payments
    #@payments = @expo.payments.where(is_accountant_check: false ).page(params[:id])
  end

  def exhibitor_finance_is_ok
    @exhibitor = Exhibitor.where(status: 0).find(params[:id])
    if @exhibitor.update(status: 1)
      # 解锁用户
      @exhibitor.user.unlock_access!
      flash[:notice] = "审核通过"
    else
      flash[:error] = "审核失败"
    end
    redirect_to exhibitors_card_payment_check_index_path(expo_id: params[:expo_id])
  end

  #审核之后不通过,并发送消息，check_message
  def exhibitor_finance_is_not_ok
    @exhibitor = Exhibitor.where(status: 0).find(params[:id])
    if @exhibitor.update(status: -1, error_msg: params[:msg])
      flash[:notice] = "审核不通过"
    else
      flash[:error] = "审核失败"
    end
    redirect_to exhibitors_card_payment_check_index_path(expo_id: params[:expo_id])
  end


  private

  def set_expo
    if params[:expo_id].blank?
      @expo = Expo.first
    else
      @expo = Expo.find(params[:expo_id])
    end
  end


  def set_title
    @title = "缴费管理"
  end
end
