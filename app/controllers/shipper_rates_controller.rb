class ShipperRatesController < ApplicationController
  before_action :set_shipper_rate, only: [:show, :edit, :update, :destroy]
  before_action :set_previous_controller, only: [:show, :edit, :update, :destroy, :new]

  # GET /shipper_rates
  # GET /shipper_rates.json
  def index
    @shipper_rates = ShipperRate.all
    authorize @shipper_rates
  end

  # GET /shipper_rates/1
  # GET /shipper_rates/1.json
  def show
  end

  # GET /shipper_rates/new
  def new
    @shipper_rate = ShipperRate.new
    if params[:client_id].present?
      @shipper_rate.client_id = params[:client_id]
    end
    if params[:shipper_id].present?
      @shipper_rate.shipper_id = params[:shipper_id]
    end
    authorize @shipper_rate
  end

  # GET /shipper_rates/1/edit
  def edit
  end

  # POST /shipper_rates
  # POST /shipper_rates.json
  def create
    @shipper_rate = ShipperRate.new(shipper_rate_params)
    respond_to do |format|
      if @shipper_rate.save
        if params[:shipper_rate][:supporting_pdf].present?
          @shipper_rate.supporting_pdf.attach(params[:shipper_rate][:supporting_pdf])
        end
        format.html { redirect_to shipper_path(:id => @shipper_rate.shipper_id), notice: 'Rate was successfully created.' }
        # format.html { redirect_to @shipper_rate, notice: 'Rate was successfully created.' }
        format.json { render :show, status: :created, location: @shipper_rate }
      else
        format.html { render :new }
        format.json { render json: @shipper_rate.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /shipper_rates/1
  # PATCH/PUT /shipper_rates/1.json
  def update
    respond_to do |format|
      if @shipper_rate.update(shipper_rate_params)
        if params[:shipper_rate][:supporting_pdf].present?
          @shipper_rate.supporting_pdf.attach(params[:shipper_rate][:supporting_pdf])
        end
        format.html { redirect_to shipper_path(:id => @shipper_rate.shipper_id), notice: 'Rate was successfully updated.' }
        # format.html { redirect_to @shipper_rate, notice: 'Rate was successfully updated.' }
        format.json { render :show, status: :ok, location: @shipper_rate }
      else
        format.html { render :edit }
        format.json { render json: @shipper_rate.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shipper_rates/1
  # DELETE /shipper_rates/1.json
  def destroy
    @shipper_rate.destroy
    respond_to do |format|
      format.html { redirect_to shipper_path(:id => @shipper_rate.shipper_id), notice: 'Rate was successfully removed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shipper_rate
      @shipper_rate = ShipperRate.find(params[:id])
      authorize @shipper_rate
    end

    def set_previous_controller
      if params[:previous_controller].present?
        @previous_controller = params[:previous_controller]
      else
        @previous_controller = 'shipper_rates'
      end
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def shipper_rate_params
      params.require(:shipper_rate).permit(:client_id, :shipper_id, :rate_type, :parent_id, :rate_level, :rep_id, :effective_to, :effective_from, :origin_location_id, :destination_location_id, :freight_desc, :freight_classification, :transit_time, :minimum_density, :origin_city, :origin_state, :origin_country, :destination_city, :destination_state, :destination_country)
    end
end
