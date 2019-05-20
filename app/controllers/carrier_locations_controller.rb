class CarrierLocationsController < ApplicationController
  before_action :set_carrier_location, only: [:show, :edit, :update, :destroy]

  # GET /carrier_locations
  # GET /carrier_locations.json
  def index
    @carrier_locations = CarrierLocation.all
    authorize @carrier_locations
  end

  # GET /carrier_locations/1
  # GET /carrier_locations/1.json
  def show
  end

  # GET /carrier_locations/new
  def new
    @carrier_location = CarrierLocation.new
    if params[:carrier_id].present?
      @carrier_location.carrier_id = params[:carrier_id]
    end
    authorize @carrier_location
  end

  # GET /carrier_locations/1/edit
  def edit
    carrier = Carrier.find_by(id: @carrier_location.carrier_id)
    @is_head_office =  carrier.head_office == @carrier_location.id
  end

  # POST /carrier_locations
  # POST /carrier_locations.json
  def create
    @carrier_location = CarrierLocation.new(carrier_location_params)

    respond_to do |format|
      if @carrier_location.save
        if params[:head_office].present? && !params[:carrier_location][:carrier_id].nil? && params[:carrier_location][:carrier_id] != ""
          carrier = Carrier.find(params[:carrier_location][:carrier_id])
          carrier.update_attributes(:head_office => @carrier_location.id)
        end
        format.html { redirect_to @carrier_location, notice: 'Location was successfully created.' }
        format.json { render :show, status: :created, carrier_location: @carrier_location }
      else
        format.html { render :new }
        format.json { render json: @carrier_location.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /carrier_locations/1
  # PATCH/PUT /carrier_locations/1.json
  def update
    respond_to do |format|
      if @carrier_location.update(carrier_location_params)
        if params[:head_office].present? && !params[:carrier_location][:carrier_id].nil? && params[:carrier_location][:carrier_id] != ""
          carrier = Carrier.find(params[:carrier_location][:carrier_id])
          carrier.update_attributes(:head_office => @carrier_location.id)
        end

        format.html { redirect_to @carrier_location, notice: 'Location was successfully updated.' }
        format.json { render :show, status: :ok, carrier_location: @carrier_location }
      else
        format.html { render :edit }
        format.json { render json: @carrier_location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /carrier_locations/1
  # DELETE /carrier_locations/1.json
  def destroy
    @carrier_location.destroy
    respond_to do |format|
      format.html { redirect_to carrier_path(:id => @carrier_location.carrier_id), notice: 'Location was successfully removed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_carrier_location
      @carrier_location = CarrierLocation.find(params[:id])
      authorize @carrier_location
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def carrier_location_params
      params[:carrier_location][:name] = params[:carrier_location][:carrier_location_name]
      params.require(:carrier_location).permit(:name, :address, :country, :state, :city, :postal, :is_origin, :is_destination, :loc_type, :phone, :carrier_id)
    end
end
