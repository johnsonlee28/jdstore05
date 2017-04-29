class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?

  helper_method :current_cart

  def current_cart
    @current_cart ||= find_cart
  end

  def find_cart
    cart = Cart.find_by(id: session[:cart_id])
    if cart.blank?
      cart = Cart.create
    end
    session[:cart_id] = cart.id
    return cart
  end

  def require_admin
    if !current_user.admin?
      flash[:warning] = "You have no permission!"
      redirect_to root_path
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password)}
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :email, :password, :current_password, :is_female, :date_of_birth, :avatar)}
  end



end
