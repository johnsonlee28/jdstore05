class SubsController < ApplicationController

  def new
    @sub = Sub.new
  end

  def create
    @sub = Sub.new(sub_params)
    @sub.save
    flash[:notice] = "成功订阅，我们会每月免费向您推介新甜!"
    redirect_to root_path
  end

  private

  def sub_params
    params.require(:sub).permit(:email)
  end
end
