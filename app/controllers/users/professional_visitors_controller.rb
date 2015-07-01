# encoding: utf-8

class Users::ProfessionalVisitorsController < ApplicationController
  before_action :authenticate_user!
  before_action :auth_professional_visitor!

  def new
    @professional_visitor = ProfessionalVisitor.new
    respond_to do |format|
      format.html # new.html.erb
    end
  end

  def create
    @professional_visitor = ProfessionalVisitor.new(professional_visitor_params)
    @professional_visitor.user = current_user
    respond_to do |format|
      if @professional_visitor.save
        set_role
        format.html { redirect_to admin_home_index_path, notice: '恭喜你注册完成' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  private
  def professional_visitor_params
    params[:professional_visitor].permit(:age, :real_name, :mobile)
  end

  def set_role
    current_user.role = Role.find_by(name: 'professional_visitor')
    current_user.save
  end

  def auth_professional_visitor!
    if current_user.type == "professional_visitor" && !current_user.professional_visitor
      return
    end
    flash[:error] = '非法提交'
    redirect_to admin_permission_denied_path
  end
end
