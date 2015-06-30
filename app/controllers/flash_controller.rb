# encoding: utf-8
class FlashController < ApplicationController

  def error
    @title = "非法操作"
  end
end
