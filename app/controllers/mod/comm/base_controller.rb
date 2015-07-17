class Mod::Comm::BaseController < Mod::Comm::ApiController
  before_action :set_mod_comm_api, only: [:show, :update, :destroy]


end
