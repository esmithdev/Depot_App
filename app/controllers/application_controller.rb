class ApplicationController < ActionController::Base
  
  before_filter :authorize # goes down to def authorize
  before_filter :set_i18n_locale_from_params
  protect_from_forgery
  
  def set_i18n_locale_from_params
  	if params[:locale]
      if I18n.available_locales.include?(params[:locale].to_sym)
  			#Rails.logger.debug 'locale is present'
        I18n.locale = params[:locale]
  		else
  			flash.now[:notice] = "#{params[:locale]} translation not available"	
  			logger.error flash.now[:notice]
  		end
  	end
  end

  def default_url_options
  	{ :locale => I18n.locale}
  end	

  #before_filter 
	private

	def current_cart
		Cart.find(session[:cart_id])
	rescue ActiveRecord::RecordNotFound
		cart = Cart.create
		session[:cart_id] = cart.id
		cart #returns cart 
	end			

	def authorize
		unless User.find_by_id(session[:user_id])
			redirect_to login_url, :notice => "Please log in"
		end 
	end
end
