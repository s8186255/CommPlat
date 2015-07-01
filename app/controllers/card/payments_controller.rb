# encoding: utf-8
class Card::PaymentsController < Card::BaseController
  # before_action :set_admin_home, only: [:show, :edit, :update, :destroy]
  # skip_before_action :role_user!
  skip_before_filter :verify_authenticity_token, :only => :create
  #主办方代待交费列表
  def index
    @paystatus = params[:paystatus]
    @expo = Expo.active.first
    # 卡片审核通过 等待付款
    if @paystatus == "ok"
      @cards = @expo.cards.where(status: 3).page(params[:page])
    else
      @cards = @expo.cards.where(status: 2).page(params[:page])
    end
    # 已缴费列表
  end

  def create
    @card_ids = params[:card_ids].split(',')
    @cards = Card.where(status: 2,:_id.in => @card_ids )
    @expo = Expo.active.first
    price = 0
    @cards.each do |card|
      price += card.card_type.price
    end
    payment = current_user.organizer.payments.build(sn: "11111", value: price, card_ids: @card_ids)
    payment.expo = @expo
    if payment.save
      flash[:notice] = "付款成功"
      # 标记card 已付款
      @cards.update_all(status: 3)
    else
      flash[:error] = "付款失败"
    end
    redirect_to card_payments_path
  end

end
