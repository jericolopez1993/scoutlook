class ClientLocationsController < ApplicationController
  before_action :set_client_location, only: [:show, :edit, :update, :destroy]

  # GET /client_locations
  # GET /client_locations.json
  def index
    @client_locations = ClientLocation.all
    authorize @client_locations
  end

  # GET /client_locations/1
  # GET /client_locations/1.json
  def show
  end

  # GET /client_locations/new
  def new
    @client_location = ClientLocation.new
    if params[:client_id].present?
      @client_location.client_id = params[:client_id]
    end
    authorize @client_location
  end

  # GET /client_locations/1/edit
  def edit
    client = Client.find(@client_location.client_id)
    @is_origin = client.origin == @client_location.id
    @is_destination = client.destination == @client_location.id
    @is_head_office = client.head_office == @client_location.id
  end

  # POST /client_locations
  # POST /client_locations.json
  def create
    @client_location = ClientLocation.new(client_location_params)
    @client_location.same_ho = params[:same_ho].present?
    if params[:client_location][:location_id].present? || params[:client_location][:address].present? ||  params[:client_location][:city].present? ||  params[:client_location][:state].present? ||  params[:client_location][:postal].present? ||  params[:client_location][:city].present?
      if params[:new_location].present?
        @location = Location.new(address_params)
        @location.save
        @location_id = @location.id
      else
        @location_id =  params[:client_location][:location_id]
      end
      @client_location.location_id = @location_id
    end

    respond_to do |format|
      if @client_location.save
        client = Client.find(@client_location.client_id)
        if params[:origin].present?
          client.update_attributes(:origin => @client_location.id)
        end
        if params[:destination].present?
          client.update_attributes(:destination => @client_location.id)
        end
        if params[:head_office].present?
          client.update_attributes(:head_office => @client_location.id)
        end
        format.html { redirect_to client_path(:id => @client_location.client_id), notice: 'Client Location was successfully created.' }
        format.json { render :show, status: :created, client_location: @client_location }
      else
        format.html { render :new }
        format.json { render json: @client_location.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /client_locations/1
  # PATCH/PUT /client_locations/1.json
  def update
    if params[:client_location][:location_id].present? || params[:client_location][:address].present? ||  params[:client_location][:city].present? ||  params[:client_location][:state].present? ||  params[:client_location][:postal].present? ||  params[:client_location][:city].present?
      if params[:new_location].present?
        @location = Location.new(address_params)
        @location.save
        @location_id = @location.id
      else
        @location_id =  params[:client_location][:location_id]
      end
    end
    params[:client_location][:location_id] = @location_id
    respond_to do |format|
      if @client_location.update(client_location_params)
        @client_location.update_attributes(:same_ho => params[:same_ho].present?)
        client = Client.find(@client_location.client_id)
        if params[:origin].present?
          client.update_attributes(:origin => @client_location.id)
        end
        if params[:destination].present?
          client.update_attributes(:destination => @client_location.id)
        end
        if params[:head_office].present?
          client.update_attributes(:head_office => @client_location.id)
        end
        format.html { redirect_to client_path(:id => @client_location.client_id), notice: 'Client Location was successfully updated.' }
        format.json { render :show, status: :ok, client_location: @client_location }
      else
        format.html { render :edit }
        format.json { render json: @client_location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /client_locations/1
  # DELETE /client_locations/1.json
  def destroy
    @client_location.destroy
    respond_to do |format|
      format.html { redirect_to client_path(:id => @client_location.client_id), notice: 'Client Location was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def origin_destination
    @origin = ""
    @destination = ""

    if params[:origin].present?
      origin = ClientLocation.find(params[:origin])
      @origin = origin.state + "," + origin.country
    end

    if params[:destination].present?
      destination = ClientLocation.find(params[:destination])
      @destination = destination.state + "," + destination.country
    end

    render json: {:origin => @origin, :destination => @destination}
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client_location
      @client_location = ClientLocation.find(params[:id])
      authorize @client_location
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def client_location_params
      params.require(:client_location).permit(:client_id, :client_location_id, :name, :loc_type, :special_instructions, :phone, :poc_id, :soc_id, :location_id)
    end
    def address_params
      params.require(:client_location).permit(:address, :city, :state, :postal, :country)
    end
end
