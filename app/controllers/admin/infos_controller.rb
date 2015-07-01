# encoding: utf-8
class Admin::InfosController < Admin::AdminBaseController
  before_action :info_user!, only: [:index, :new, :edit, :create, :update, :destroy, :top]

  #增加权限配置
  #先判断信息类型
  #再判断控制器和action

  #信息列表
  def index
    @infos = Info.includes(:items, :user).where(info_type_id: params[:info_type_id]).page(params[:page])
  end

  #信息明细
  def show
    @info = Info.includes( :items).find params[:id]
    @items = @info.items.sort
  end

  # GET /user/homes/new
  #新建信息
  def new
    @item_types = @info_type.item_types
    @items = []
    @info = Info.new
  end

  #新建信息
  def create
    ih = InfoHandler.new info_type: @info_type,
      user: current_user,
      items: params[:items],
      info: params[:info]
    if ih.create_info
      redirect_to admin_info_type_infos_path, notice: "新建成功"
    else
      flash[:error] = "新建失败"
      redirect_to new_admin_info_type_info_path
    end
  end

  #修订信息
  def edit
    @item_types = @info_type.item_types
    @items = @info.items.sort
  end

  #修订信息
  def update
    Rails.logger.debug "-------update------------"
    @info.update(params[:info].permit(:title))
    Rails.logger.debug params[:items]
    if params[:items]
      params[:items].each do |item_id, value|
        Rails.logger.debug '-----------'
        old_item= Item.find(item_id)
        if [Settings.content_type.attachment, Settings.content_type.image, Settings.content_type.video].include?(old_item.item_type.content_type)
          attachment = old_item.attachments.first
          if attachment
            attachment.update(asset: value)
          else
            attachment = Attachment::Asset.new(asset: value)
            attachment.owner_id = old_item.id
            attachment.save
          end
        else
          old_item.update(value: value)
        end
      end
    end

    redirect_to admin_info_type_infos_path, notice: "修改成功"
  end

  #删除信息
  def destroy
    @info.destroy
    respond_to do |format|
      format.html { redirect_to admin_info_type_infos_path(@info_type), notice: '删除成功' }
      format.json { head :no_content }
    end
  end

  def top
    if @info.top
      @info.update_attribute(:top, false)
    else
      @info.update_attribute(:top, true)
    end
    flash[:notice] = "置顶成功"
    redirect_to admin_info_type_infos_path(@info_type)
  end

  private


  def set_title
    @title = "信息管理"
  end

  def info_user!
    @info_type = InfoType.includes(:item_types).find(params[:info_type_id])
    if params[:id]
      @info = Info.find(params[:id])
    end
    info_permissions=current_user.role.info_permissions
    if info_permissions.first && info_permissions.first.info_name == "all"
      @info_actions = [:manager]
      @self_info = true
      return
    end

    info_permissions.each do |info_permission|
      if info_permission.info_name == @info_type.name
        actions = info_permission.actions
        @info_actions = actions
        if action_name == "index" || action_name == "show"
          if actions.include?(:manager) || actions.include?(:read)
            return
          end
        elsif action_name == "update" || action_name == "edit" || action_name == "top"
          if  (actions.include?(:manager) || actions.include?(:update)) &&  @info.user == current_user
            return
          end
        elsif action_name == "new" || action_name == "create"
          if  actions.include?(:manager) || actions.include?(:create)
            return
          end
        elsif action_name == "destroy"
          if  (actions.include?(:manager) || actions.include?(:destroy)) && @info.user == current_user
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
