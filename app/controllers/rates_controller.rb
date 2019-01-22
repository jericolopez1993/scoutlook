class RatesController < ApplicationController
  before_action :set_rate, only: [:show, :edit, :update, :destroy]
  before_action :set_previous_controller, only: [:show, :edit, :update, :destroy, :new]

  # GET /rates
  # GET /rates.json
  def index
    @rates = Rate.all
    authorize @rates
  end

  # GET /rates/1
  # GET /rates/1.json
  def show
  end

  # GET /rates/new
  def new
    @rate = Rate.new
    if params[:activity_id].present?
      @rate.activity_id = params[:activity_id]
    end
    if @previous_controller == "carriers"
      @activities = Activity.where(:carrier_id => params[:carrier_id])
      @rate_carrier_id = ""
    elsif @previous_controller == "shippers"
      @activities = Activity.where(:shipper_id => params[:shipper_id])
      @rate_carrier_id = ""
    end
    authorize @rate
  end

  # GET /rates/1/edit
  def edit
    if @previous_controller == "carriers" || @client_type == "carrier"
      @activities = Activity.where(:carrier_id => params[:carrier_id])
      @rate_carrier_id = @rate.carrier_id
    elsif @previous_controller == "shippers" || @client_type == "shipper"
      @activities = Activity.where(:shipper_id => params[:shipper_id])
      @rate_shipper_id = @rate.shipper_id
    end
    authorize @rate
  end

  # POST /rates
  # POST /rates.json
  def create
    @rate = Rate.new(rate_params)
    respond_to do |format|
      if @rate.save
        if params[:rate][:supporting_pdf].present?
          @rate.supporting_pdf.attach(params[:rate][:supporting_pdf])
        end
        if @rate.carrier
          format.html { redirect_to @rate.carrier, notice: 'Rate was successfully created.' }
        elsif @rate.shipper
          format.html { redirect_to @rate.shipper, notice: 'Rate was successfully created.' }
        elsif @rate.activity
          format.html { redirect_to activity_path(:id => @rate.activity_id), notice: 'Rate was successfully created.' }
        else
          format.html { redirect_to @rate, notice: 'Rate was successfully created.' }
        end
        # format.html { redirect_to @rate, notice: 'Rate was successfully created.' }
        format.json { render :show, status: :created, location: @rate }
      else
        format.html { render :new }
        format.json { render json: @rate.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rates/1
  # PATCH/PUT /rates/1.json
  def update
    respond_to do |format|
      if @rate.update(rate_params)
        if params[:rate][:supporting_pdf].present?
          @rate.supporting_pdf.attach(params[:rate][:supporting_pdf])
        end
        if @rate.carrier
          format.html { redirect_to @rate.carrier, notice: 'Rate was successfully updated.' }
        elsif @rate.shipper
          format.html { redirect_to @rate.shipper, notice: 'Rate was successfully updated.' }
        elsif @rate.activity
          format.html { redirect_to activity_path(:id => @rate.activity_id), notice: 'Rate was successfully updated.' }
        else
          format.html { redirect_to @rate, notice: 'Rate was successfully updated.' }
        end
        format.json { render :show, status: :ok, location: @rate }
      else
        format.html { render :edit }
        format.json { render json: @rate.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rates/1
  # DELETE /rates/1.json
  def destroy
    @rate.destroy
    respond_to do |format|
      if @previous_controller != 'rates'
        if @rate.carrier
          format.html { redirect_to @rate.carrier, notice: 'Rate was successfully updated.' }
        elsif @rate.shipper
          format.html { redirect_to @rate.shipper, notice: 'Rate was successfully updated.' }
        else
          format.html { redirect_to activity_path(:id => @rate.activity_id), notice: 'Rate was successfully removed.' }
        end
      else
        format.html { redirect_to rates_path(), notice: 'Rate was successfully removed.' }
      end
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rate
      @rate = Rate.find(params[:id])
      authorize @rate
    end

    def set_previous_controller
      if params[:previous_controller].present?
        @previous_controller = params[:previous_controller]
      else
        @previous_controller = 'rates'
      end
      if @previous_controller == "rates"
        @client_type = params[:client_type]
      end
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def rate_params
      params[:rate][:bid] = convert_decimal(params[:rate][:bid])
      params[:rate][:ask] = convert_decimal(params[:rate][:ask])
      params[:rate][:cost] = convert_decimal(params[:rate][:cost])
      params[:rate][:commodities] = convert_array(params[:rate][:commodities])
      params.require(:rate).permit(:carrier_id, :carrier_contact_id, :shipper_id, :shipper_contact_id, :activity_id, :rate_type, :parent_id, :rate_level, :user_id, :effective_to, :effective_from, :origin_location_id, :destination_location_id, :freight_desc, :freight_classification, :transit_time, :minimum_density, :origin_city, :origin_state, :origin_country, :destination_city, :destination_state, :destination_country, :miles, :picks, :drops, :team, :commodities, :bid, :ask, :cost, :money_currency, :mc_number, :notes, :accepted)
    end
end
