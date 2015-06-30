# encoding: utf-8
class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]
  before_action :set_info_menus, only: [:edit, :update]
  layout :by_action
  #layout 'back/admin', only: [:edit, :update]
  # GET /resource/sign_up
  def new
    @user_type = params[:user_type]
    if params[:step] == "1"
      p @user_type
      redirect_to users_agree_path(user_type: @user_type)
      return
    end
    if @user_type and params[:step] == "2"
      build_resource({})
      ##set_minimum_password_length
      resource.build_exhibitor
      resource.build_professional_visitor
      respond_with self.resource
    else
      redirect_to admin_permission_denied_path, notice: "非法操作"
    end
  end

  # POST /resource
  def create
    @user_type =  params[:user][:type]
    #防止用户篡改用户角色
    if @user_type.include?('admin')
      flash[:error] = "对不起您的操作有误，如有问题请联系网站管理员"
      redirect_to error_path
      return
    end
    super do |resource|
      resource.role = Role.find_by(name: @user_type)
    end
  end


  # GET /resource/edit
  #def edit
  #super
  #end

  # PUT /resource
  #def update
  #self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
  #prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)

  #resource_updated = update_resource(resource, account_update_params)
  #yield resource if block_given?
  #if resource_updated
  #if is_flashing_format?
  #flash_key = update_needs_confirmation?(resource, prev_unconfirmed_email) ?
  #:update_needs_confirmation : :updated
  #set_flash_message :notice, flash_key
  #end
  ##更新exhibitor
  #if self.resource.exhibitor
  #self.resource.exhibitor.update
  #end

  ##更新professional_visitor
  #if self.resource.professional_visitor
  #end

  #sign_in resource_name, resource, bypass: true
  #respond_with resource, location: after_update_path_for(resource)
  #else
  #clean_up_passwords resource
  #respond_with resource
  #end
  #end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end
  #

  protected
  # You can put the params you want to permit in the empty array.
  def configure_sign_up_params
    devise_parameter_sanitizer.for(:sign_up) { |u|
      u.permit(:username, :email, :type, :password, :password_confirmation, exhibitor_attributes: [:real_name, :phone, :mobile, scopes: []], professional_visitor_attributes: [:real_name, :mobile, :english_name, :sex, :company_name, :company_addr, :job, :department, :area, :phone, :fax, :qq, :weixin, :website])
    }
  end

  # You can put the params you want to permit in the empty array.
  def configure_account_update_params
    devise_parameter_sanitizer.for(:account_update) { |u|
      u.permit( :email, :password, :password_confirmation, :current_password, exhibitor_attributes: [:real_name, :phone, :mobile, scopes: []], professional_visitor_attributes: [:real_name, :mobile, :english_name, :sex, :company_name, :company_addr, :job, :department, :area, :phone, :fax, :qq, :weixin, :website])
    }
  end

  #注册后 邮箱未确认跳转地址
  def after_inactive_sign_up_path_for(resource)
    users_ok_path
  end
  #修改个人资料后 跳转地址
  def after_update_path_for(resource_or_scope)
    edit_user_registration_path
  end

  def set_info_menus
    info_permissions_names = current_user.role.info_permissions.only(:info_name).map(&:info_name)
    if info_permissions_names.include?("all")
      @menu_info_types = InfoType.all
    else
      @menu_info_types = InfoType.where(:name.in => info_permissions_names)
    end
  end
  #修改个人资料 无需密码

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
  def by_action
    if action_name == "new" ||  action_name == "create"
      "front/home"
    elsif action_name = "update" || action_name = "edit"
      "back/admin"
    else
      "back/admin"
    end
  end

end
