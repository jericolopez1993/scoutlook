class MasterInvoicesController < ApplicationController
  before_action :set_master_invoice, only: [:show, :edit, :update, :destroy]

  # GET /master_invoices
  # GET /master_invoices.json
  def index
    @master_invoices = MasterInvoice.all
  end

  # GET /master_invoices/1
  # GET /master_invoices/1.json
  def show
  end

  # GET /master_invoices/new
  def new
    @master_invoice = MasterInvoice.new
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
        if @master_invoice.shipment_entry == "single shipment"
            @shipment = Shipment.new(shipment_params)
            @shipment.total_charge = params[:master_invoice][:total_charge_shipment]
            @shipment.header = @master_invoice.id
            @shipment.save
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
        if @master_invoice.shipment_entry == "single shipment"
            @shipments = Shipment.where(:header => @master_invoice.id)
            if @shipments.present? && !@shipments.nil?
              params[:master_invoice][:total_charge] = params[:master_invoice][:total_charge_shipment]
              @shipment = @shipments.first
              @shipment.update(shipment_params)
            else
              @shipment = Shipment.new(shipment_params)
              @shipment.total_charge = params[:master_invoice][:total_charge_shipment]
              @shipment.header = @master_invoice.id
              @shipment.save
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
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def master_invoice_params
      params.require(:master_invoice).permit(:shipment_type, :shipper_id, :carrier_id, :master_account, :single_invoice_date, :invoicing_period_start, :invoicing_period_end, :total_charge, :variance, :variance_approved, :shipment_entry)
    end

    def shipment_params
      params.require(:master_invoice).permit(:header, :shipment_date, :tracking_number, :terms, :origin_id, :origin_location_id, :destination_id, :destination_location_id, :distance, :pieces, :pallets, :unit_of_weight, :declared_weight, :billed_weight, :raw_weight, :service_mode, :billed_rate, :billed_rate_unit, :surcharge_ontario, :surcharge_non_conveyables, :surcharge_non_vault, :surchange_multi_piece, :surcharge_fuel, :surcharge_weight, :gst_hst_tax, :total_charge, :total_charge_with_tax)
    end
end
