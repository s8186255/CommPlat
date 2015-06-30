class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  #登陆成功后 跳转地址
  def after_sign_in_path_for(resource_or_scope)
    admin_home_index_path
  end

  #登出后 跳转地址
  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end


  # The path used after sign up.
  #def after_sign_up_path_for(resource_or_scope)
  ##if resource.type == "exhibitor"
  ##flash[:info] = '最后一步，请完善个人资料完成注册'
  ##new_users_exhibitor_path
  ##elsif resource.type == "professional_visitor"
  ##flash[:info] = '最后一步，请完善个人资料完成注册'
  ##new_users_professional_visitor_path
  ##else
  ##flash[:error] = '非法操作'
  ##admin_permission_denied_path
  ##end
  #users_ok_path
  #end

protected
  #在某个action中设置需要传递到下一个action的参数，参数以hash的方式
  def set_step_params action_name,opts={}# 类似{a:1,b:2}
    session[:step]={} if session[:step].blank?
    session[:step]["#{action_name}"]=opts
  end
  def get_step_params
    session[:step]
  end

end
