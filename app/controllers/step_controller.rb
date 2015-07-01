# encoding: utf-8

class StepController < ApplicationController
  def step_one
    opts={"a"=>1,"b"=>2}
    set_step_params self.action_name,opts
    @hello = get_step_params
    render 'test'
  end
  def step_two
    opts={"c"=>1,"d"=>2}
    set_step_params self.action_name,opts
    @hello = get_step_params
    render 'test'
  end

end
