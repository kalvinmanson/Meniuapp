class Api::V1::PlacesController < ApplicationController
  def index
    #define location
    if params['lat'].present? && params['lng'].present?
      @lat = search_params[:lat]
      @lng = search_params[:lng]
    elsif current_user.present?
      @lat = current_user.lat
      @lng = current_user.lng
    else
      @lat = search_params[:lat]
      @lng = search_params[:lng]
    end
    #if query keyword
    if params['q'].present?
      @q = search_params[:q]
      @plates = Plate.where('plates.name LIKE "%"?"%"', @q).or(Plate.where('plates.tags LIKE "%"?"%"', @q)).or(Plate.where('plates.content LIKE "%"?"%"', @q)).joins(:place).by_distance(:origin => [@lat,@lng])
    else
      @plates = Plate.joins(:place).by_distance(:origin => [@lat,@lng])
    end

    #if prices
    if search_params[:min_price].present?
      @min_price = search_params[:min_price]
      @plates = @plates.where('plates.price >= ?', @min_price)
    end
    #if prices
    if search_params[:max_price].present?
      @max_price = search_params[:max_price]
      @plates = @plates.where('plates.price <= ?', @max_price)
    end

    @plates = @plates.limit(50)
    @places = Place.by_distance(:origin => [@lat,@lng]).limit(4)

    #save Quest
    @quest =Quest.new
    #save user if exists
    if current_user.present?
      @quest.user = current_user
    else
      @quest.user = User.first
    end
    #Save query keyword if exists
    if @q.present?
      @quest.quest = @q
    else
      @quest.quest = 'FrontPage'
    end
    #geolocation Quest
    @quest.lat = @lat
    @quest.lng = @lng

    @quest.save

    render json: @plates
  end

  private
    def search_params
      params.permit(:q, :lat, :lng, {:options => []}, :category, :min_price, :max_price)
    end
end
