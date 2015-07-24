class Mod::Comm::GroupsController < ApplicationController
  #before_action :set_mod_comm_api, only: [:show, :update, :destroy]

  #组的列表；
  def index
 @groups = Mod::Comm::Group.all
  end

  #新建一个组
  def create

  end
  #删除一个组
  def destroy

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
