# encoding: utf-8

class HomeController < ApplicationController
  #layout "front/display" #这是列表页和detail页
  layout "front/home" #这是首页

  def index
    @hot_news = InfoType.find_by(name: "news").infos.top(10)
    @links =InfoType.find_by(name: "links").infos
    @basic_info = InfoType.find_by(name: "about").infos.find_by(title: "展会简介")
    @zg_info = InfoType.find_by(name: "about").infos.find_by(title: "展馆介绍")
    @deadline = InfoType.find_by(name: "deadline").infos.first
    @img_infos = InfoType.find_by(name: "position_img").infos
  end

  def zx
  end

end
