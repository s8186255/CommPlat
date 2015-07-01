# encoding: utf-8

class Card::RolesController < Card::BaseController
  before_action :get_role, only: [:show, :edit, :destroy, :create_controller_permission, :create_info_permission]

  def index
    @roles = Role.order({ created_at: "desc"}).page(params[:page])
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @roles }
    end
  end

  # GET /roles/1
  # GET /roles/1.xml
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @role }
    end
  end


  # GET /roles/new
  # GET /roles/new.xml
  def new
    @role = Role.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @role }
    end
  end

  # GET /roles/1/edit
  def edit
  end

  # POST /roles
  # POST /roles.xml
  def create
    @role = Role.new(params[:role])

    respond_to do |format|
      if @role.save
        flash[:notice] = 'Role was successfully created.'
        format.html { redirect_to([:admin,@role]) }
        format.xml  { render :xml => @role, :status => :created, :location => @role }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @role.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /roles/1
  # PUT /roles/1.xml
  def update
    respond_to do |format|
      if @role.update_attributes(params[:role])
        flash[:notice] = 'Role was successfully updated.'
        format.html { redirect_to([:admin,@role]) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @role.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /roles/1
  # DELETE /roles/1.xml
  def destroy
    if @role.users.size > 0
      flash[:error] = "角色删除失败,角色下还有用户,不能删除!"
    else
      @role.destroy
      flash[:notice] = "角色删除成功!"
    end
    respond_to do |format|
      format.html { redirect_to(admin_roles_path) }
      format.xml  { head :ok }
    end
  end

  #新增 controller_permission
  def create_controller_permission
    @controller_permission = ControllerPermission.new
    @controller_permission.controller_name = params[:roles][:controller_permission][:controller_name]
    @controller_permission.desc = params[:roles][:controller_permission][:desc]
    @controller_permission.actions = params[:roles][:controller_permission][:actions].split(",").map! {|action| action.to_sym}
    @controller_permission.role = @role
    respond_to do |format|
      if @controller_permission.save
        format.js {}
      else
        format.xml  { render :xml => @role.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy_controller_permission
    @controller_permission = ControllerPermission.find(params[:controller_permission_id])
    respond_to do |format|
      if @controller_permission.destroy
        format.js {}
      else
        format.js {}
      end
    end
  end

  #新增 info_type_permission 
  def create_info_permission
    @info_permission = InfoPermission.new
    @info_permission.info_name = params[:roles][:info_permission][:info_name]
    @info_permission.desc = params[:roles][:info_permission][:desc]
    @info_permission.actions = params[:roles][:info_permission][:actions].split(",").map! {|action| action.to_sym}
    @info_permission.info_type = InfoType.find_by(name: @info_permission.info_name)
    @info_permission.role = @role
    respond_to do |format|
      if @info_permission.save
        format.js {}
      else
        format.xml  { render :xml => @role.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy_info_permission
    @info_permission = InfoPermission.find(params[:info_permission_id])
    respond_to do |format|
      if @info_permission.destroy
        format.js {}
      else
        format.xml  { render :xml => @role.errors, :status => :unprocessable_entity }
      end
    end
  end

  private
  def set_title
    @title = "角色维护"
  end

  def get_role
    @role = Role.find(params[:id])
  end

  def controller_permission_params
    params[:roles][:controller_permission].permit(:controller_name, :desc, :actions)
  end

  def info_type_permission_params
    params[:info_type_permission_params].permit(:name, :desc, :actions)
  end
end
