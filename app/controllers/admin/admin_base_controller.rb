# encoding: utf-8
class Admin::AdminBaseController< ApplicationController
  before_action :authenticate_user!
  before_action :role_user!
  layout 'back/card'
  before_action :set_title
  #before_action :set_info_menus

  protected
  #def set_info_menus
    #info_permissions_names = current_user.role.info_permissions.only(:info_name).map(&:info_name)
    #if info_permissions_names.include?("all")
      #@menu_info_types = InfoType.all
    #else
      #@menu_info_types = InfoType.where(:name.in => info_permissions_names)
    #end
  #end

  def set_title
    @title = "首页"
  end

  def role_user!
    current_user.role.controller_permissions.each do |controller_permission|
      if controller_permission.controller_name == controller_name
        actions = controller_permission.actions
        @role_actions = actions
        if actions.include?(:manager)
          return
        end
        if action_name == "index" || action_name == "show"
          if actions.include?(:read)
            return
          end
        elsif action_name == "update" || action_name == "edit"
          if  actions.include?(:update)
            return
          end
        elsif action_name == "new" || action_name == "create"
          if  actions.include?(:create)
            return
          end
        elsif action_name == "destroy"
          if  actions.include?(:destroy)
            return
          end
        elsif action_name == "lock"
          if  actions.include?(:lock)
            return
          end
        else
          if actions.include?(action_name.to_sym)
            return
          end
        end
        break
      end
    end
    flash[:error] = "没有权限查看此页"
    redirect_to admin_permission_denied_path
  end
end
