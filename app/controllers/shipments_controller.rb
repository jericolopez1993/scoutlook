class ShipmentsController < ApplicationController
include HTTParty
  before_action :set_shipment, only: [:show, :edit, :update, :destroy]

  # GET /shipments
  # GET /shipments.json
  def index
    @shipments = Shipment.all
    authorize @shipments
  end

  # GET /shipments/1
  # GET /shipments/1.json
  def show
  end

  # GET /shipments/new
  def new
    @shipment = Shipment.new
    if params[:header].present?
      @shipment.header = params[:header]
    end
    authorize @shipment
  end

  # GET /shipments/1/edit
  def edit
  end

  # POST /shipments
  # POST /shipments.json
  def create
    @shipment = Shipment.new(shipment_params)
    @origin_location_id = nil
    @destination_location_id = nil
    if params[:shipment][:origin_location_id].present? || params[:shipment][:origin_address].present? || params[:shipment][:origin_country].present? ||  params[:shipment][:origin_state].present? ||  params[:shipment][:origin_postal].present? ||  params[:shipment][:origin_city].present?
      if params[:origin_new_location].present?
        location = Location.new
        location.address = params[:shipment][:origin_address]
        location.country = params[:shipment][:origin_country]
        location.state = params[:shipment][:origin_state]
        location.city = params[:shipment][:origin_city]
        location.postal = params[:shipment][:origin_postal]
        location.save
        @origin_location_id = location.id
      else
        @origin_location_id =  params[:shipment][:origin_location_id]
      end
    end
    @shipment.origin_location_id = @origin_location_id
    if params[:shipment][:destination_location_id].present? || params[:shipment][:destination_address].present? ||  params[:shipment][:destination_country].present? ||  params[:shipment][:destination_state].present? ||  params[:shipment][:destination_postal].present? ||  params[:shipment][:destination_city].present?
      if params[:destination_new_location].present?
        location = Location.new
        location.address = params[:shipment][:destination_address]
        location.country = params[:shipment][:destination_country]
        location.state = params[:shipment][:destination_state]
        location.city = params[:shipment][:destination_city]
        location.postal = params[:shipment][:destination_postal]
        location.save
        @destination_location_id = location.id
      else
        @destination_location_id =  params[:shipment][:destination_location_id]
      end
    end
    @shipment.destination_location_id = @destination_location_id

    origin = Location.find(@origin_location_id)
    @origin = origin.address + " " + origin.state + "," + origin.country
    destination = Location.find(@destination_location_id)
    @destination = destination.address + " " +destination.state + "," + destination.country
    str_url = "https://maps.googleapis.com/maps/api/distancematrix/json?&origins=" + @origin + "&destinations=" + @destination + "&key=AIzaSyCbFFNkesD-8_F4lMdyihwqpARlDYmG6k0"
    response = HTTParty.get(str_url)
    body = JSON.parse(response.body)
    @shipment.distance = body['rows'][0]['elements'][0]['distance']['value'] / 1000

    respond_to do |format|
      if @shipment.save
        if params[:shipment][:shipment_attachment_file].present?
          @shipment.shipment_attachment_file.attach(params[:shipment][:shipment_attachment_file])
        end
        format.html { redirect_to master_invoice_path(:id => @shipment.header), notice: 'Shipment was successfully created.' }
        format.json { render :show, status: :created, location: @shipment }
      else
        format.html { render :new }
        format.json { render json: @shipment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /shipments/1
  # PATCH/PUT /shipments/1.json
  def update
    @origin_location_id = nil
    @destination_location_id = nil
    if params[:shipment][:origin_location_id].present? || params[:shipment][:origin_address].present? ||  params[:shipment][:origin_country].present? ||  params[:shipment][:origin_state].present? ||  params[:shipment][:origin_postal].present? ||  params[:client_location][:origin_city].present?
      if params[:origin_new_location].present?
        location = Location.new
        location.address = params[:shipment][:origin_address]
        location.country = params[:shipment][:origin_country]
        location.state = params[:shipment][:origin_state]
        location.city = params[:shipment][:origin_city]
        location.postal = params[:shipment][:origin_postal]
        location.save
        @origin_location_id = location.id
      else
        @origin_location_id =  params[:shipment][:origin_location_id]
      end
    end
    params[:shipment][:origin_location_id] = @origin_location_id
    if params[:shipment][:destination_location_id].present? || params[:shipment][:destination_address].present? ||  params[:shipment][:destination_country].present? ||  params[:shipment][:destination_state].present? ||  params[:shipment][:destination_postal].present? ||  params[:client_location][:destination_city].present?
      if params[:destination_new_location].present?
        location = Location.new
        location.address = params[:shipment][:destination_address]
        location.country = params[:shipment][:destination_country]
        location.state = params[:shipment][:destination_state]
        location.city = params[:shipment][:destination_city]
        location.postal = params[:shipment][:destination_postal]
        location.save
        @destination_location_id = location.id
      else
        @destination_location_id =  params[:shipment][:destination_location_id]
      end
    end
    params[:shipment][:destination_location_id] = @destination_location_id

    origin = Location.find(@origin_location_id)
    @origin = origin.address + " " + origin.state + "," + origin.country
    destination = Location.find(@destination_location_id)
    @destination = destination.address + " " +destination.state + "," + destination.country
    str_url = "https://maps.googleapis.com/maps/api/distancematrix/json?&origins=" + @origin + "&destinations=" + @destination + "&key=AIzaSyCbFFNkesD-8_F4lMdyihwqpARlDYmG6k0"
    response = HTTParty.get(str_url)
    body = JSON.parse(response.body)
    params[:shipment][:distance] = body['rows'][0]['elements'][0]['distance']['value'] / 1000

    respond_to do |format|
      if @shipment.update(shipment_params)
        if params[:shipment][:shipment_attachment_file].present?
          @shipment.shipment_attachment_file.attach(params[:shipment][:shipment_attachment_file])
        end
        format.html { redirect_to master_invoice_path(:id => @shipment.header), notice: 'Shipment was successfully updated.' }
        format.json { render :show, status: :ok, location: @shipment }
      else
        format.html { render :edit }
        format.json { render json: @shipment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shipments/1
  # DELETE /shipments/1.json
  def destroy
    @shipment.destroy
    respond_to do |format|
      format.html { redirect_to master_invoice_path(:id => @shipment.header), notice: 'Shipment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shipment
      @shipment = Shipment.find(params[:id])
      authorize @shipment
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def shipment_params
      params[:shipment][:billed_rate] = params[:shipment][:billed_rate].gsub('$ ', '').gsub(',', '').to_d
      params[:shipment][:surcharge_ontario] = params[:shipment][:surcharge_ontario].gsub('$ ', '').gsub(',', '').to_d
      params[:shipment][:surcharge_non_conveyables] = params[:shipment][:surcharge_non_conveyables].gsub('$ ', '').gsub(',', '').to_d
      params[:shipment][:surcharge_non_vault] = params[:shipment][:surcharge_non_vault].gsub('$ ', '').gsub(',', '').to_d
      params[:shipment][:surchange_multi_piece] = params[:shipment][:surchange_multi_piece].gsub('$ ', '').gsub(',', '').to_d
      params[:shipment][:surcharge_fuel] = params[:shipment][:surcharge_fuel].gsub('$ ', '').gsub(',', '').to_d
      params[:shipment][:surcharge_weight] = params[:shipment][:surcharge_weight].gsub('$ ', '').gsub(',', '').to_d
      params[:shipment][:gst_hst_tax] = params[:shipment][:gst_hst_tax].gsub('$ ', '').gsub(',', '').to_d
      params[:shipment][:total_charge] = params[:shipment][:total_charge].gsub('$ ', '').gsub(',', '').to_d
      params[:shipment][:total_charge_with_tax] = params[:shipment][:total_charge_with_tax].gsub('$ ', '').gsub(',', '').to_d
      params[:shipment][:shipment_date] = Date::strptime(params[:shipment][:shipment_date], "%m/%d/%Y")
      params.require(:shipment).permit(:header, :account_number, :shipment_date, :tracking_number, :terms, :origin_location_id, :destination_location_id, :distance, :pieces, :pallets, :unit_of_weight, :declared_weight, :billed_weight, :raw_weight, :service_mode, :billed_rate, :billed_rate_unit, :surcharge_ontario, :surcharge_non_conveyables, :surcharge_non_vault, :surchange_multi_piece, :surcharge_fuel, :surcharge_weight, :gst_hst_tax, :total_charge, :total_charge_with_tax, :notes)
    end
end
