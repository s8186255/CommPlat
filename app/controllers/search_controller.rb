class SearchController < ApplicationController
  layout "front/home" #这是首页

  def index
    @infos =Info.full_text_search(params[:q]).page()
  end
end
