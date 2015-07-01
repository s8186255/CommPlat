# encoding: utf-8
class Card::FlashController < Card::BaseController
  skip_before_action :role_user!
  def permission_denied
    @title = "禁止访问"
  end

end
