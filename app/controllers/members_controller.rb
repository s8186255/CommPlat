# encoding: utf-8

class MembersController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => :login_ok
  def login

  end

  def login_ok
    authenticate params[:user]
  end

  def failed

  end
end
