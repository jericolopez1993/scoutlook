class ShipmentsController < ApplicationController
  before_action :set_shipment, only: [:show, :edit, :update, :destroy]

  # GET /shipments
  # GET /shipments.json
  def index
    @shipments = Shipment.all
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

  end

  # GET /shipments/1/edit
  def edit
  end

  # POST /shipments
  # POST /shipments.json
  def create
    @shipment = Shipment.new(shipment_params)

    respond_to do |format|
      if @shipment.save
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
    respond_to do |format|
      if @shipment.update(shipment_params)
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
      params.require(:shipment).permit(:header, :account_number, :invoice_number, :shipment_date, :tracking_number, :terms, :origin_id, :origin_location_id, :destination_id, :destination_location_id, :distance, :pieces, :pallets, :unit_of_weight, :declared_weight, :billed_weight, :raw_weight, :service_mode, :billed_rate, :billed_rate_unit, :surcharge_ontario, :surcharge_non_conveyables, :surcharge_non_vault, :surchange_multi_piece, :surcharge_fuel, :surcharge_weight, :gst_hst_tax, :total_charge, :total_charge_with_tax, :notes)
    end
end
