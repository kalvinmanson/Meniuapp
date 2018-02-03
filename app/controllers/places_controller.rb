class PlacesController < ApplicationController

  load_and_authorize_resource :place
  before_action :set_place, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy, :charts, :my, :data]

  def my
    @places = Place.where(user: current_user).all
  end

  def data
    @place = Place.find(params[:place_id])

    #Set days
    #Quitar dias .days_ago(-1)
    if params['date_to'].present? && params['date_from'].present?
      @date_to    = Date.parse(params['date_to'])
      @date_from  = Date.parse(params['date_from'])
    else
      @date_to    = Date.today
      @date_from  = @date_to.days_ago(7)
    end


    @days = (@date_from..@date_to).map(&:to_s)
    @visits = @place.visits.where(:created_at => @date_from..@date_to).order(created_at: :desc)
    @votes = @place.votes.where(:created_at => @date_from..@date_to).order(created_at: :desc)
    @quests = @place.quests.where(:created_at => @date_from..@date_to).order(created_at: :desc)

  end

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

  end

  def show
    #If quest asigned
    if params[:quest].present?
      @quest = Quest.find(params[:quest])
      if @quest.present?
        @quest.visited_place = @place.id
        @quest.save
      end
    end
    #If quest asigned end
  end

  def new
    @place = Place.new
  end

  # GET /places/1/edit
  def edit
  end

  # POST /places
  # POST /places.json
  def create
    @place = Place.new(place_params)
    @place.user = current_user
    @place.rank = 0
    @place.views = 0
    if @place.save
      redirect_to place_path(@place), notice: 'Place was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /places/1
  # PATCH/PUT /places/1.json
  def update
    if @place.update(place_params)
      redirect_to place_path(@place), notice: 'Place was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /places/1
  # DELETE /places/1.json
  def destroy
    @place.destroy
    redirect_to places_url, notice: 'Place was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_place
      @place = Place.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def place_params
      params.require(:place).permit(:user_id, :category_id, :name, :slug, :address, :phone, :email, :description, :rank, :views, :lat, :lng, :expires_at, :cover, :avatar, :logo)
    end

    def search_params
      params.permit(:q, :lat, :lng, {:options => []}, :category, :min_price, :max_price)
    end
end
