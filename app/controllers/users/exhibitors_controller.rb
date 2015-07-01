# encoding: utf-8

class Users::ExhibitorsController < ApplicationController
  before_action :authenticate_user!
  before_action :auth_exhibitor!

  def new
    @exhibitor = Exhibitor.new
    respond_to do |format|
      format.html # new.html.erb
    end
  end

  def create
    @exhibitor = Exhibitor.new(exhibitor_params)
    @exhibitor.user = current_user
    respond_to do |format|
      if @exhibitor.save
        set_role
        format.html { redirect_to admin_home_index_path, notice: '恭喜你注册完成' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  private
  def exhibitor_params
    params[:exhibitor].permit(:name, :real_name, :mobile)
  end

  def set_role
    current_user.role = Role.find_by(name: 'exhibitor')
    current_user.save
  end

  def auth_exhibitor!
    if current_user.type == "exhibitor" && !current_user.exhibitor
      return
    end
    flash[:error] = '非法提交'
    redirect_to admin_permission_denied_path
  end

end
