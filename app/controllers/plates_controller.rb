class PlatesController < ApplicationController

  load_and_authorize_resource :place
  load_and_authorize_resource :plate, through: :place

  before_action :set_plate, only: [:show, :edit, :update, :destroy]
  before_action :set_place

  # GET /plates
  # GET /plates.json
  def index
    @plate =Plate.new
    @plates = Plate.all

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

  # GET /plates/1
  # GET /plates/1.json
  def show
    @plate.views += 1;
    @plate.save

    #If quest asigned
    if params[:quest].present?
      @quest = Quest.find(params[:quest])
      if @quest.present?
        @quest.visited_place = @place.id
        @quest.visited_plate = @plate.id
        @quest.save
      end
    end
    #If quest asigned end
  end

  # GET /plates/new
  def new
    @plate = Plate.new
  end

  # GET /plates/1/edit
  def edit
  end

  # POST /plates
  # POST /plates.json
  def create
    @plate = Plate.new(plate_params)
    @plate.place = @place
    @plate.views = 0;
    @plate.rank = 0;

    respond_to do |format|
      if @plate.save
        format.html { redirect_to place_plate_path(@place, @plate), notice: 'Plate was successfully created.' }
        format.json { render :show, status: :created, location: @plate }
      else
        format.html { render :new }
        format.json { render json: @plate.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /plates/1
  # PATCH/PUT /plates/1.json
  def update
    respond_to do |format|
      if @plate.update(plate_params)
        format.html { redirect_to place_plates_path(@place), notice: 'Plate was successfully updated.' }
        format.json { render :show, status: :ok, location: @plate }
      else
        format.html { render :edit }
        format.json { render json: @plate.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /plates/1
  # DELETE /plates/1.json
  def destroy
    @plate.destroy
    respond_to do |format|
      format.html { redirect_to plates_url, notice: 'Plate was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_plate
      @plate = Plate.find(params[:id])
    end
    def set_place
      @place = Place.find(params[:place_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def plate_params
      params.require(:plate).permit(:place_id, :name, :slug, :content, :favored, :active, :price, :tags, :picture)
    end
end
