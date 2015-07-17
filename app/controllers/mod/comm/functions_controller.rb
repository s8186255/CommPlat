class Mod::Comm::FunctionsController < Mod::Comm::BaseController
  before_action :set_mod_comm_api, only: [:show, :update, :destroy]

  def meeting
    #参数说明
    #第一种参数：一组电话号码；
    #第二种参数：一个组的名称；

    #将这组电话，发送到后台，形成呼叫；
    phones = params[:phones]
    phone_group = params[:phone_group]

    unless phones.blank?

    end

    unless phone_group.blank?

    end
  end

  def record
    #参数说明

  end

  def message
    #参数说明

  end


  private

  def set_mod_comm_api
    @mod_comm_api = Mod::Comm::Api.find(params[:id])
  end

  def mod_comm_api_params
    params[:mod_comm_api]
  end
end
