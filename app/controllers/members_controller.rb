# encoding: utf-8

class MembersController < ApplicationController

  def login

  end

  def login_ok
    authenticate params[:user]
  end


end
