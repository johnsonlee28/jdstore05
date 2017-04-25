class CartsController < ApplicationController

  def empty
    current_cart.clean!
    redirect_to carts_path
  end

end
