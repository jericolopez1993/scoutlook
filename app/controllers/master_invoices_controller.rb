class MasterInvoicesController < ApplicationController
  include HTTParty
  include ApplicationHelper
  before_action :set_master_invoice, only: [:show, :edit, :update, :destroy]

  require 'time'

  # GET /master_invoices
  # GET /master_invoices.json
  def index
    @master_invoices = MasterInvoice.all
    authorize @master_invoices
  end

  # GET /master_invoices/1
  # GET /master_invoices/1.json
  def show
  end

  # GET /master_invoices/new
  def new
    @master_invoice = MasterInvoice.new
    authorize @master_invoice
  end

  # GET /master_invoices/1/edit
  def edit
  end

  # POST /master_invoices
  # POST /master_invoices.json
  def create
    @master_invoice = MasterInvoice.new(master_invoice_params)
    @master_invoice.variance_approved = params[:variance_approved].present?
    respond_to do |format|
      if @master_invoice.save
        if params[:master_invoice][:attachment_file].present?
          @master_invoice.attachment_file.attach(params[:master_invoice][:attachment_file])
        end
          if @master_invoice.shipment_entry == "single shipment"
            @shipment = Shipment.new(shipment_params)
            @origin_location_id = nil
            @destination_location_id = nil
            if params[:master_invoice][:origin_location_id].present? || params[:master_invoice][:origin_address].present? || params[:master_invoice][:origin_country].present? ||  params[:master_invoice][:origin_state].present? ||  params[:master_invoice][:origin_postal].present? ||  params[:master_invoice][:origin_city].present?
              if is_numeric?(params[:master_invoice][:origin_location_id])
                  @origin_location_id = params[:master_invoice][:origin_location_id]
              else
                location = Location.new
                location.name = params[:master_invoice][:origin_location_id]
                location.address = params[:master_invoice][:origin_address]
                location.country = params[:master_invoice][:origin_country]
                location.state = params[:master_invoice][:origin_state]
                location.city = params[:master_invoice][:origin_city]
                location.postal = params[:master_invoice][:origin_postal]
                location.save
                @origin_location_id = location.id
              end
            end
            @shipment.origin_location_id = @origin_location_id
            if params[:master_invoice][:destination_location_id].present? || params[:master_invoice][:destination_address].present? || params[:master_invoice][:destination_country].present? ||  params[:master_invoice][:destination_state].present? ||  params[:master_invoice][:destination_postal].present? ||  params[:master_invoice][:destination_city].present?
              if is_numeric?(params[:master_invoice][:destination_location_id])
                  @destination_location_id = params[:master_invoice][:destination_location_id]
              else
                location = Location.new
                location.name = params[:master_invoice][:destination_location_id]
                location.address = params[:master_invoice][:destination_address]
                location.country = params[:master_invoice][:destination_country]
                location.state = params[:master_invoice][:destination_state]
                location.city = params[:master_invoice][:destination_city]
                location.postal = params[:master_invoice][:destination_postal]
                location.save
                @destination_location_id = location.id
              end
            end
              @shipment.destination_location_id = @destination_location_id
            if !@origin_location_id.nil? && !@destination_location_id.nil?
              origin = Location.find(@origin_location_id)
              @origin = origin.address + " " + origin.state + "," + origin.country
              destination = Location.find(@destination_location_id)
              @destination = destination.address + " " +destination.state + "," + destination.country
              begin
                str_url = "https://maps.googleapis.com/maps/api/distancematrix/json?&origins=" + @origin + "&destinations=" + @destination + "&key=AIzaSyCbFFNkesD-8_F4lMdyihwqpARlDYmG6k0"
                response = HTTParty.get(str_url)
                body = JSON.parse(response.body)
                temp_distance =  body['rows'][0]['elements'][0]['distance']['value'].nil? ? 0 :  body['rows'][0]['elements'][0]['distance']['value']
                distance = temp_distance / 1000
                @shipment.distance = distance
              rescue
                puts 'Google Maps API error'
              end
            else
              @shipment.distance = 0
            end

            @shipment.total_charge = params[:master_invoice][:total_charge_shipment]
            @shipment.header = @master_invoice.id
            @shipment.save
            if params[:master_invoice][:shipment_attachment_file].present?
              @shipment.shipment_attachment_file.attach(params[:master_invoice][:shipment_attachment_file])
            end
        end
        format.html { redirect_to @master_invoice, notice: 'Master invoice was successfully created.' }
        format.json { render :show, status: :created, location: @master_invoice }
      else
        format.html { render :new }
        format.json { render json: @master_invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /master_invoices/1
  # PATCH/PUT /master_invoices/1.json
  def update
    params[:master_invoice][:variance_approved] = params[:variance_approved].present?
    respond_to do |format|
      if @master_invoice.update(master_invoice_params)
        if params[:master_invoice][:attachment_file].present?
          @master_invoice.attachment_file.attach(params[:master_invoice][:attachment_file])
        end
        if @master_invoice.shipment_entry == "single shipment"
            @shipments = Shipment.where(:header => @master_invoice.id)
            @origin_location_id = nil
            @destination_location_id = nil
            if params[:master_invoice][:origin_location_id].present? || params[:master_invoice][:origin_address].present? || params[:master_invoice][:origin_country].present? ||  params[:master_invoice][:origin_state].present? ||  params[:master_invoice][:origin_postal].present? ||  params[:master_invoice][:origin_city].present?
              if is_numeric?(params[:master_invoice][:origin_location_id])
                  @origin_location_id =  params[:master_invoice][:origin_location_id]
              else
                location = Location.new
                location.name = params[:master_invoice][:origin_location_id]
                location.address = params[:master_invoice][:origin_address]
                location.country = params[:master_invoice][:origin_country]
                location.state = params[:master_invoice][:origin_state]
                location.city = params[:master_invoice][:origin_city]
                location.postal = params[:master_invoice][:origin_postal]
                location.save
                @origin_location_id = location.id
              end
            end
            params[:master_invoice][:origin_location_id] = @origin_location_id
            if params[:master_invoice][:destination_location_id].present? || params[:master_invoice][:destination_address].present? || params[:master_invoice][:destination_country].present? ||  params[:master_invoice][:destination_state].present? ||  params[:master_invoice][:destination_postal].present? ||  params[:master_invoice][:destination_city].present?
              if is_numeric?(params[:master_invoice][:destination_location_id])
                  @destination_location_id = params[:master_invoice][:destination_location_id]
              else
                location = Location.new
                location.name = params[:master_invoice][:destination_location_id]
                location.address = params[:master_invoice][:destination_address]
                location.country = params[:master_invoice][:destination_country]
                location.state = params[:master_invoice][:destination_state]
                location.city = params[:master_invoice][:destination_city]
                location.postal = params[:master_invoice][:destination_postal]
                location.save
                @destination_location_id = location.id
              end
            end
            params[:master_invoice][:destination_location_id] = @destination_location_id
            if !@origin_location_id.nil? && !@destination_location_id.nil?
              origin = Location.find(@origin_location_id)
              @origin = origin.address + " " + origin.state + "," + origin.country
              destination = Location.find(@destination_location_id)
              @destination = destination.address + " " +destination.state + "," + destination.country
              str_url = "https://maps.googleapis.com/maps/api/distancematrix/json?&origins=" + @origin + "&destinations=" + @destination + "&key=AIzaSyCbFFNkesD-8_F4lMdyihwqpARlDYmG6k0"
              response = HTTParty.get(str_url)
              body = JSON.parse(response.body)
              temp_distance =  body['rows'][0]['elements'][0]['distance']['value'].nil? ? 0 :  body['rows'][0]['elements'][0]['distance']['value']
              params[:master_invoice][:distance] = temp_distance / 1000
            else
              params[:master_invoice][:distance] = 0
            end

            if @shipments.present? && !@shipments.nil?
              @shipment = @shipments.first
              @shipment.update(shipment_params)
            else
              @shipment = Shipment.new(shipment_params)
              @shipment.total_charge = params[:master_invoice][:total_charge_shipment]
              @shipment.header = @master_invoice.id
              @shipment.save
            end
            if params[:master_invoice][:shipment_attachment_file].present?
              @shipment.shipment_attachment_file.attach(params[:master_invoice][:shipment_attachment_file])
            end
        end
        format.html { redirect_to @master_invoice, notice: 'Master invoice was successfully updated.' }
        format.json { render :show, status: :ok, location: @master_invoice }
      else
        format.html { render :edit }
        format.json { render json: @master_invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /master_invoices/1
  # DELETE /master_invoices/1.json
  def destroy
    @master_invoice.destroy
    respond_to do |format|
      format.html { redirect_to master_invoices_url, notice: 'Master invoice was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_master_invoice
      @master_invoice = MasterInvoice.find(params[:id])
      authorize @master_invoice
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def master_invoice_params
      params.require(:master_invoice).permit(:invoice_number, :master_invoice_type, :shipper_id, :carrier_id, :master_account, :single_invoice_date, :invoicing_period_start, :invoicing_period_end, :total_charge, :variance_approved, :shipment_entry)
    end

    def shipment_params
      params[:master_invoice][:billed_rate] = params[:master_invoice][:billed_rate].gsub('$ ', '').gsub(',', '').to_d
      params[:master_invoice][:surcharge_ontario] = params[:master_invoice][:surcharge_ontario].gsub('$ ', '').gsub(',', '').to_d
      params[:master_invoice][:surcharge_non_conveyables] = params[:master_invoice][:surcharge_non_conveyables].gsub('$ ', '').gsub(',', '').to_d
      params[:master_invoice][:surcharge_non_vault] = params[:master_invoice][:surcharge_non_vault].gsub('$ ', '').gsub(',', '').to_d
      params[:master_invoice][:surchange_multi_piece] = params[:master_invoice][:surchange_multi_piece].gsub('$ ', '').gsub(',', '').to_d
      params[:master_invoice][:surcharge_fuel] = params[:master_invoice][:surcharge_fuel].gsub('$ ', '').gsub(',', '').to_d
      params[:master_invoice][:surcharge_weight] = params[:master_invoice][:surcharge_weight].gsub('$ ', '').gsub(',', '').to_d
      params[:master_invoice][:gst_hst_tax] = params[:master_invoice][:gst_hst_tax].gsub('$ ', '').gsub(',', '').to_d
      params[:master_invoice][:total_charge] = params[:master_invoice][:total_charge_shipment].gsub('$ ', '').gsub(',', '').to_d
      params[:master_invoice][:total_charge_with_tax] = params[:master_invoice][:total_charge_with_tax].gsub('$ ', '').gsub(',', '').to_d
      params[:master_invoice][:shipment_date] = Date::strptime(params[:master_invoice][:shipment_date], "%m/%d/%Y")
      params.require(:master_invoice).permit(:header, :account_number, :shipment_date, :tracking_number, :terms, :origin_location_id, :destination_location_id, :distance, :pieces, :pallets, :unit_of_weight, :declared_weight, :billed_weight, :raw_weight, :service_mode, :billed_rate, :billed_rate_unit, :surcharge_ontario, :surcharge_non_conveyables, :surcharge_non_vault, :surchange_multi_piece, :surcharge_fuel, :surcharge_weight, :gst_hst_tax, :total_charge, :total_charge_with_tax, :notes)
    end
end
