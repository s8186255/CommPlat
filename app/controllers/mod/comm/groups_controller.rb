class Mod::Comm::GroupsController < ApplicationController
  #before_action :set_mod_comm_api, only: [:show, :update, :destroy]
  before_filter :authenticate
  skip_before_filter :verify_authenticity_token
  #组的列表；
  def index
    puts params[:phones]

 @groups = Mod::Comm::Group.all
  end

  #新建一个组
  def create
#params
    #name
    #phones
    puts params[:phones]
    puts params[:groupName]
    Mod::Comm::Group.create name: params[:groupName],phones: params[:phones]#,user_id:'1234'
    render json: {result:'ok'}
  end
  #删除一个组
  def destroy
Group.find_by(id:params[:id]).destroy
  end

  #添加一个号码到组中；
  def add

  end
  #从一个组中删除一个号码
  def remove

  end


  private

  def set_mod_comm_api
    @mod_comm_api = Mod::Comm::Api.find(params[:id])
  end

  def mod_comm_api_params
    params[:mod_comm_api]
  end
end
