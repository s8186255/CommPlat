# encoding: utf-8
class Card::ApplysController < Card::BaseController
  before_action :set_card, only: [ :apply]
  #skip_before_action :role_user!


  #提交制卡申请
  def apply
    unless @card.sn
      flash[:error] = "请先上报信息，确认信息无误后再进行提交"
      redirect_to card_cards_path
      return
    end
    if @card.status <= 0
      @card.update(status: 1)
      flash[:notice] = "提交成功，请耐心等待审核"
    else
      flash[:error] = "已经提交，无法提交!"
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

  def set_title
    @title = "展会管理"
  end
end
