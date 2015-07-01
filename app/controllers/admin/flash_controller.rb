# encoding: utf-8
class Admin::FlashController < Admin::AdminBaseController
  skip_before_action :role_user!
  def permission_denied
    @title = "禁止访问"
  end

end
