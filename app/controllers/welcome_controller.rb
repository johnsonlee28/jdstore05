class WelcomeController < ApplicationController
  def index
    flash[:notice] = "hello man!"
  end
end
