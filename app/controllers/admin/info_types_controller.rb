# encoding: utf-8
class Admin::InfoTypesController < Admin::AdminBaseController
  #layout "back/admin"
  #skip_before_action :role_user!
  before_action :set_info_type, only: [:destroy, :edit, :show, :update]

  def index
    @info_types=InfoType.all.page(params[:page])
  end

  def new
    @info_type=InfoType.new
    @item_type=ItemType.new
    @content_types=Settings.content_type.collections
  end

  def create
    #创建信息类型需要创建两个对象：info_type本身，还有一组item_type对象集
    #infotype本身只有两个属性：name和description，比较简单
    ih = InfoHandler.new info_type: params[:info_type],
      item_type: params[:item_type]
    if ih.create_info_type
      flash[:notice] = "新建信息类型成功"
      redirect_to admin_info_types_url
    else
      flash[:error] = "新建信息失败"
      redirect_to new_admin_info_type_url
    end
  end

  def show
  end

  #old
  def edit
  end

  def update
    @info_type = @info_type.update(params[:info_type].permit(:name, :desc, :type, :has_child, :position))
    if @info_type

      flash[:notice] = "更新成功"
    else
      flash[:error] = "更新失败"
    end
    redirect_to :action => 'index'
  end

  def destroy
    if @info_type.infos.size > 0
      flash[:error] = "无法删除，请先删除该类型下的所有信息"
      redirect_to :action => 'index'
      return
    end
    @info_type.destroy
    flash[:notice] = "删除成功"
    redirect_to :action => 'index'
  end

  private

  #destroy edit show
  def set_info_type
    @info_type = InfoType.includes(:item_types).find(params[:id])
  end

  def set_title
    @title = "信息类型管理"
  end
  #old
  def update_infotype
    @info_type = InfoType.find params[:id]
    @item_types = @info_type.item_types

    #item_type有name、position、info_type_id、content_type_id四个需要填写的属性
    field_names=params[:item_type_names]||[]
    content_type_ids=params[:content_type_ids]||[]

    @info_type.update_attributes params[:info_type]
    n = 0
    @item_types.each do |item_type|
      #n = item_type.position
      if item_type.id == params[:item_type_id_if_title].to_i
        item_type.update_attributes(:name => field_names[n],
                                    :content_type_id => content_type_ids[n],
                                    :if_title => true)
        n+=1
      else
        item_type.update_attributes(:name => field_names[n],
                                    :content_type_id => content_type_ids[n])
        n+=1

      end
    end
    redirect_to "/admin/info_types"
  end

end
