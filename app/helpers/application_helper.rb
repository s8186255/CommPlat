# encoding: utf-8
module ApplicationHelper

  #管理员后台 左侧菜单显示
  def display_nav? controller_name_or_info_type
    #info_type = InfoType.find_by(name: controller_name_or_info_type)
    role =  current_user.role
    #if info_type
    #return true if role.info_permissions.find_by(info_type_id: info_type.id)
    #else
    return true if role.controller_permissions.find_by(controller_name: controller_name_or_info_type)
    #end
    false
  end


  # 生成bootstrap 提示栏
  def bootstrap_class_for flash_type
    alert_hash = { success: "alert-success", error: "alert-danger", alert: "alert-warning", notice: "alert-info" }
    alert_hash[flash_type.to_sym] || flash_type.to_s
  end

  def flash_messages(opts = {})
    flash.each do |msg_type, message|
      concat(content_tag(:div, message, class: "alert #{bootstrap_class_for(msg_type)} ") do
        concat content_tag(:button, 'x', class: "close", data: { dismiss: 'alert' })
        concat message
      end)
    end
    nil
  end

  #标题字符限制20个字符
  def title_str(title, length = 20)
    if title.length > length
      title[0, length] + "..."
    else
      title
    end
  end

  def time_f(time)
    time.strftime("%F %T")
  end

  # 最新信息
  def new?(info)
    if Time.now - info.created_at < 1.hour
      "<span class=\"label label-danger\">New</span>"
    end
  end

  def is_new?(info)
    Time.now - info.created_at < 1.hour
  end

  def top?(info)
    if info.top
      "<span class=\"label label-info\">Top</span>"
    end
  end

  # 生成操作按钮 显示 编辑 新建 和删除
  def operation_to(actions, label, path, options={}, ourself=true )
    logger.debug "-------------"
    logger.debug actions
    if ourself
      if actions
        if actions.include?(:manager)
          return link_to label, path, {class: "btn btn-default btn-sm"}.merge!(options)
        end
        if label == "显示" && actions.include?(:read)
          return link_to label, path, {class: "btn btn-default btn-sm"}.merge!(options)
        elsif (label == "编辑" || label.include?("置顶")) && actions.include?(:update)
          return link_to label, path, {class: "btn btn-default btn-sm"}.merge!(options)
        elsif label == "新建" && actions.include?(:create)
          return link_to label, path, {class: "btn btn-default btn-sm"}.merge!(options)
        elsif label == "删除" && actions.include?(:destroy)
          return link_to label, path, {class: "btn btn-default btn-sm"}.merge!(options)
        end
      end
    else
      options.merge!({disabled: "true"})
      link_to label, path, {class: "btn btn-default btn-sm"}.merge!(options)
    end
  end

  def content_type_desc(id)
    if id ==Settings.content_type.text
      "纯文本"
    elsif id==Settings.content_type.rich_text
      "富文本"
    elsif id==Settings.content_type.geo
      "地理坐标"
    elsif id==Settings.content_type.attachment
      "附件"
    elsif id==Settings.content_type.image
      "图片"
    elsif id==Settings.content_type.video
      "视频"
    end
  end

  def self_info? info
    if current_user.type == "admin" || info.user == current_user
      true
    else
      false
    end
  end

  # 前台的helper

  #日期格式化 只显示日期
  def date_f(datetime)
    datetime.strftime("%F")
  end
end
