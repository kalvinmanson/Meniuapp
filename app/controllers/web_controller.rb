class WebController < ApplicationController

  # GET /votes
  # GET /votes.json
  def index

  end

  def how

  end

  def set_location
    session[:lat] = params[:latitude]
    session[:lng] = params[:longitude]
  	if current_user.present?
  		if params[:latitude].present? && params[:longitude].present?
  			current_user.lat = params[:latitude]
  			current_user.lng = params[:longitude]
  		else
  			current_user.lat = request.location.latitude
  			current_user.lng = request.location.longitude
        session[:lat] = request.location.latitude
        session[:lng] = request.location.longitude
  		end

  		current_user.save(validate: false)
  		render json: '{"lat": "' + current_user.lat.to_s + '", "lng": "' + current_user.lng.to_s + '"}'
  	end
  end

end
