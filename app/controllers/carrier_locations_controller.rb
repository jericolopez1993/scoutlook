class CarrierLocationsController < ApplicationController
  include ApplicationHelper
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
    carrier = Carrier.find(@carrier_location.carrier_id)
    @is_origin = carrier.origin == @carrier_location.id
    @is_destination = carrier.destination == @carrier_location.id
    @is_head_office = carrier.head_office == @carrier_location.id
  end

  # POST /carrier_locations
  # POST /carrier_locations.json
  def create
    @carrier_location = CarrierLocation.new(carrier_location_params)
    @carrier_location.same_ho = params[:same_ho].present?
    if params[:carrier_location][:location_id].present? || params[:carrier_location][:address].present? ||  params[:carrier_location][:city].present? ||  params[:carrier_location][:state].present? ||  params[:carrier_location][:postal].present? ||  params[:carrier_location][:city].present?
      if is_numeric?(params[:carrier_location][:location_id])
        @location_id =  params[:carrier_location][:location_id]
      else
        @location = Location.new(address_params)
        @location.name = params[:carrier_location][:location_id]
        @location.save
        @location_id = @location.id
      end
      @carrier_location.location_id = @location_id
    end

    respond_to do |format|
      if @carrier_location.save
        carrier = Carrier.find(@carrier_location.carrier_id)
        if params[:origin].present?
          carrier.update_attributes(:origin => @carrier_location.id)
        end
        if params[:destination].present?
          carrier.update_attributes(:destination => @carrier_location.id)
        end
        if params[:head_office].present?
          carrier.update_attributes(:head_office => @carrier_location.id)
        end
        format.html { redirect_to carrier_path(:id => @carrier_location.carrier_id), notice: 'Carrier Location was successfully created.' }
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
    if params[:carrier_location][:location_id].present? || params[:carrier_location][:address].present? ||  params[:carrier_location][:city].present? ||  params[:carrier_location][:state].present? ||  params[:carrier_location][:postal].present? ||  params[:carrier_location][:city].present?
      puts is_numeric?(params[:carrier_location][:location_id])
      if is_numeric?(params[:carrier_location][:location_id])
        @location_id =  params[:carrier_location][:location_id]
      else
        @location = Location.new(address_params)
        @location.name = params[:carrier_location][:location_id]
        @location.save
        @location_id = @location.id
      end
    end
    params[:carrier_location][:location_id] = @location_id
    respond_to do |format|
      if @carrier_location.update(carrier_location_params)
        @carrier_location.update_attributes(:same_ho => params[:same_ho].present?)
        carrier = Carrier.find(@carrier_location.carrier_id)
        if params[:origin].present?
          carrier.update_attributes(:origin => @carrier_location.id)
        end
        if params[:destination].present?
          carrier.update_attributes(:destination => @carrier_location.id)
        end
        if params[:head_office].present?
          carrier.update_attributes(:head_office => @carrier_location.id)
        end
        format.html { redirect_to carrier_path(:id => @carrier_location.carrier_id), notice: 'Carrier Location was successfully updated.' }
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
      format.html { redirect_to carrier_path(:id => @carrier_location.carrier_id), notice: 'Carrier Location was successfully destroyed.' }
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
      params.require(:carrier_location).permit(:carrier_id, :carrier_location_id, :name, :loc_type, :special_instructions, :phone, :poc_id, :soc_id, :location_id)
    end
    def address_params
      params.require(:carrier_location).permit(:address, :city, :state, :postal, :country)
    end
end
