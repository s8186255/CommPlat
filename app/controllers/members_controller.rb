# encoding: utf-8

class MembersController < ApiController
  skip_before_filter :verify_authenticity_token, :only => :login_ok


  def login
    authenticate params[:user]
  end


end
