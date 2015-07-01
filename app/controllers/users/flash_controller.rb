class Users::FlashController < ApplicationController
  layout "front/home"
  def ok
  end

  def agree
    @user_type = params[:user_type]
  end
end
