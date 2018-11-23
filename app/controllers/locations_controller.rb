class LocationsController < ApplicationController
  before_action :set_location, only: [:show, :edit, :update, :destroy]

  # GET /locations
  # GET /locations.json
  def index
    @locations = Location.all
    authorize @locations
  end

  # GET /locations/1
  # GET /locations/1.json
  def show
  end

  # GET /locations/new
  def new
    @location = Location.new
    if params[:client_id].present?
      @location.client_id = params[:client_id]
    end
    authorize @location
  end

  # GET /locations/1/edit
  def edit
    client = Client.find(@location.client_id)
    @is_head_office = client.head_office == @location.id
  end

  # POST /locations
  # POST /locations.json
  def create
    @location = Location.new(location_params)

    respond_to do |format|
      if @location.save
        if params[:head_office].present? && !params[:location][:client_id].nil? && params[:location][:client_id] != ""
          client = Client.find(params[:location][:client_id])
          client.update_attributes(:head_office => @location.id)
        end
        format.html { redirect_to client_path(:id => @location.client_id), notice: 'Location was successfully created.' }
        format.json { render :show, status: :created, location: @location }
      else
        format.html { render :new }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /locations/1
  # PATCH/PUT /locations/1.json
  def update
    respond_to do |format|
      if @location.update(location_params)
        if params[:head_office].present? && !params[:location][:client_id].nil? && params[:location][:client_id] != ""
          client = Client.find(params[:location][:client_id])
          client.update_attributes(:head_office => @location.id)
        end
        format.html { redirect_to client_path(:id => @location.client_id), notice: 'Location was successfully updated.' }
        format.json { render :show, status: :ok, location: @location }
      else
        format.html { render :edit }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /locations/1
  # DELETE /locations/1.json
  def destroy
    @location.destroy
    respond_to do |format|
      format.html { redirect_to locations_url, notice: 'Location was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_location
      @location = Location.find(params[:id])
      authorize @location
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def location_params
      params[:location][:is_origin] = params[:origin].present?
      params[:location][:is_destination] = params[:destination].present?
      params[:location][:name] = params[:location][:location_name]
      params.require(:location).permit(:name, :address, :country, :state, :city, :postal, :is_origin, :is_destination, :loc_type, :phone, :client_id)
    end
end
