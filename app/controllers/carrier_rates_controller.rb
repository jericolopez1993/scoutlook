class CarrierRatesController < ApplicationController
  before_action :set_carrier_rate, only: [:show, :edit, :update, :destroy]
  before_action :set_previous_controller, only: [:show, :edit, :update, :destroy, :new]

  # GET /carrier_rates
  # GET /carrier_rates.json
  def index
    @carrier_rates = CarrierRate.all
    authorize @carrier_rates
  end

  # GET /carrier_rates/1
  # GET /carrier_rates/1.json
  def show
  end

  # GET /carrier_rates/new
  def new
    @carrier_rate = CarrierRate.new
    if params[:client_id].present?
      @carrier_rate.client_id = params[:client_id]
    end
    if params[:carrier_id].present?
      @carrier_rate.carrier_id = params[:carrier_id]
    end
    authorize @carrier_rate
  end

  # GET /carrier_rates/1/edit
  def edit
  end

  # POST /carrier_rates
  # POST /carrier_rates.json
  def create
    @carrier_rate = CarrierRate.new(carrier_rate_params)
    respond_to do |format|
      if @carrier_rate.save
        if params[:carrier_rate][:supporting_pdf].present?
          @carrier_rate.supporting_pdf.attach(params[:carrier_rate][:supporting_pdf])
        end
        format.html { redirect_to carrier_path(:id => @carrier_rate.carrier_id), notice: 'Rate was successfully created.' }
        # format.html { redirect_to @carrier_rate, notice: 'Rate was successfully created.' }
        format.json { render :show, status: :created, location: @carrier_rate }
      else
        format.html { render :new }
        format.json { render json: @carrier_rate.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /carrier_rates/1
  # PATCH/PUT /carrier_rates/1.json
  def update
    respond_to do |format|
      if @carrier_rate.update(carrier_rate_params)
        if params[:carrier_rate][:supporting_pdf].present?
          @carrier_rate.supporting_pdf.attach(params[:carrier_rate][:supporting_pdf])
        end
        format.html { redirect_to carrier_path(:id => @carrier_rate.carrier_id), notice: 'Rate was successfully updated.' }
        # format.html { redirect_to @carrier_rate, notice: 'Rate was successfully updated.' }
        format.json { render :show, status: :ok, location: @carrier_rate }
      else
        format.html { render :edit }
        format.json { render json: @carrier_rate.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /carrier_rates/1
  # DELETE /carrier_rates/1.json
  def destroy
    @carrier_rate.destroy
    respond_to do |format|
      format.html { redirect_to carrier_path(:id => @carrier_rate.carrier_id), notice: 'Rate was successfully removed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_carrier_rate
      @carrier_rate = CarrierRate.find(params[:id])
      authorize @carrier_rate
    end

    def set_previous_controller
      if params[:previous_controller].present?
        @previous_controller = params[:previous_controller]
      else
        @previous_controller = 'carrier_rates'
      end
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def carrier_rate_params
      params.require(:carrier_rate).permit(:client_id, :carrier_id, :rate_type, :parent_id, :rate_level, :user_id, :effective_to, :effective_from, :origin_location_id, :destination_location_id, :freight_desc, :freight_classification, :transit_time, :minimum_density, :origin_city, :origin_state, :origin_country, :destination_city, :destination_state, :destination_country)
    end
end
