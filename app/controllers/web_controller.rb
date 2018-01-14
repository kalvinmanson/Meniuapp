class WebController < ApplicationController

  # GET /votes
  # GET /votes.json
  def index

  end
  
  def how

  end

  def set_location
  	if current_user.present?
  		if params[:latitude].present? && params[:longitude].present?
  			current_user.lat = params[:latitude]
  			current_user.lng = params[:longitude]
  		else
  			current_user.lat = request.location.latitude
  			current_user.lng = request.location.longitude
  		end

  		current_user.save
  		render json: '{"lat": "' + current_user.lat.to_s + '", "lng": "' + current_user.lng.to_s + '"}'
  	end
  end

end
