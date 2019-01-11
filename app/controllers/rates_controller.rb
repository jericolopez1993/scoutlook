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
    authorize @rate
  end

  # GET /rates/1/edit
  def edit
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
        format.html { redirect_to activity_path(:id => @rate.activity_id), notice: 'Rate was successfully created.' }
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
        format.html { redirect_to activity_path(:id => @rate.activity_id), notice: 'Rate was successfully updated.' }
        # format.html { redirect_to @rate, notice: 'Rate was successfully updated.' }
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
      format.html { redirect_to activity_path(:id => @rate.activity_id), notice: 'Rate was successfully removed.' }
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
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def rate_params
      params[:rate][:bid] = params[:rate][:bid].gsub('$ ', '').gsub(',', '').to_d
      params[:rate][:ask] = params[:rate][:ask].gsub('$ ', '').gsub(',', '').to_d
      params[:rate][:cost] = params[:rate][:cost].gsub('$ ', '').gsub(',', '').to_d
      params[:rate][:commodities] = convert_array(params[:rate][:commodities])
      params.require(:rate).permit(:client_id, :activity_id, :rate_type, :parent_id, :rate_level, :user_id, :effective_to, :effective_from, :origin_location_id, :destination_location_id, :freight_desc, :freight_classification, :transit_time, :minimum_density, :origin_city, :origin_state, :origin_country, :destination_city, :destination_state, :destination_country, :miles, :picks, :drops, :team, :commodities, :bid, :ask, :cost, :money_currency, :mc_number, :notes, :accepted)
    end
end
