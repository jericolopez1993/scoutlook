class ShipperLocationsController < ApplicationController
  before_action :set_shipper_location, only: [:show, :edit, :update, :destroy]

  # GET /shipper_locations
  # GET /shipper_locations.json
  def index
    @shipper_locations = ShipperLocation.all
    authorize @shipper_locations
  end

  # GET /shipper_locations/1
  # GET /shipper_locations/1.json
  def show
  end

  # GET /shipper_locations/new
  def new
    @shipper_location = ShipperLocation.new
    if params[:shipper_id].present?
      @shipper_location.shipper_id = params[:shipper_id]
    end
    authorize @shipper_location
  end

  # GET /shipper_locations/1/edit
  def edit
    shipper = Shipper.find_by(id: @shipper_location.shipper_id)
    @is_head_office =  shipper.head_office == @shipper_location.id
  end

  # POST /shipper_locations
  # POST /shipper_locations.json
  def create
    @shipper_location = ShipperLocation.new(shipper_location_params)

    respond_to do |format|
      if @shipper_location.save
        if params[:head_office].present? && !params[:shipper_location][:shipper_id].nil? && params[:shipper_location][:shipper_id] != ""
          shipper = Shipper.find(params[:shipper_location][:shipper_id])
          shipper.update_attributes(:head_office => @shipper_location.id)
        end
        format.html { redirect_to shipper_path(:id => @shipper_location.shipper_id), notice: 'Location was successfully created.' }
        format.json { render :show, status: :created, shipper_location: @shipper_location }
      else
        format.html { render :new }
        format.json { render json: @shipper_location.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /shipper_locations/1
  # PATCH/PUT /shipper_locations/1.json
  def update
    respond_to do |format|
      if @shipper_location.update(shipper_location_params)
        if params[:head_office].present? && !params[:shipper_location][:shipper_id].nil? && params[:shipper_location][:shipper_id] != ""
          shipper = Shipper.find(params[:shipper_location][:shipper_id])
          shipper.update_attributes(:head_office => @shipper_location.id)
        end

        format.html { redirect_to shipper_path(:id => @shipper_location.shipper_id), notice: 'Location was successfully updated.' }
        format.json { render :show, status: :ok, shipper_location: @shipper_location }
      else
        format.html { render :edit }
        format.json { render json: @shipper_location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shipper_locations/1
  # DELETE /shipper_locations/1.json
  def destroy
    @shipper_location.destroy
    respond_to do |format|
      format.html { redirect_to shipper_path(:id => @shipper_location.shipper_id), notice: 'Location was successfully removed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shipper_location
      @shipper_location = ShipperLocation.find(params[:id])
      authorize @shipper_location
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def shipper_location_params
      params[:shipper_location][:name] = params[:shipper_location][:shipper_location_name]
      params.require(:shipper_location).permit(:name, :address, :country, :state, :city, :postal, :is_origin, :is_destination, :loc_type, :phone, :shipper_id)
    end
end
