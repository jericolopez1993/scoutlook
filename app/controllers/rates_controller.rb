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
    if params[:client_id].present?
      @rate.client_id = params[:client_id]
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

    if params[:rate][:origin_location_id].present? || params[:rate][:origin_address].present? || params[:rate][:origin_country].present? ||  params[:rate][:origin_state].present? ||  params[:rate][:origin_postal].present? ||  params[:rate][:origin_city].present?
      if params[:origin_new_location].present?
        location = Location.new
        location.address = params[:rate][:origin_address]
        location.country = params[:rate][:origin_country]
        location.state = params[:rate][:origin_state]
        location.city = params[:rate][:origin_city]
        location.postal = params[:rate][:origin_postal]
        location.save
        @origin_location_id = location.id
      else
        @origin_location_id =  params[:rate][:origin_location_id]
      end
    end
    @rate.origin_location_id = @origin_location_id
    if params[:rate][:destination_location_id].present? || params[:rate][:destination_address].present? ||  params[:rate][:destination_country].present? ||  params[:rate][:destination_state].present? ||  params[:rate][:destination_postal].present? ||  params[:rate][:destination_city].present?
      if params[:destination_new_location].present?
        location = Location.new
        location.address = params[:rate][:destination_address]
        location.country = params[:rate][:destination_country]
        location.state = params[:rate][:destination_state]
        location.city = params[:rate][:destination_city]
        location.postal = params[:rate][:destination_postal]
        location.save
        @destination_location_id = location.id
      else
        @destination_location_id =  params[:rate][:destination_location_id]
      end
    end
    @rate.destination_location_id = @destination_location_id

    respond_to do |format|
      if @rate.save
        if params[:rate][:supporting_pdf].present?
          @rate.supporting_pdf.attach(params[:rate][:supporting_pdf])
        end
        format.html { redirect_to @rate, notice: 'Rate was successfully created.' }
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
    if params[:rate][:origin_location_id].present? || params[:rate][:origin_address].present? || params[:rate][:origin_country].present? ||  params[:rate][:origin_state].present? ||  params[:rate][:origin_postal].present? ||  params[:rate][:origin_city].present?
      if params[:origin_new_location].present?
        location = Location.new
        location.address = params[:rate][:origin_address]
        location.country = params[:rate][:origin_country]
        location.state = params[:rate][:origin_state]
        location.city = params[:rate][:origin_city]
        location.postal = params[:rate][:origin_postal]
        location.save
        @origin_location_id = location.id
      else
        @origin_location_id =  params[:rate][:origin_location_id]
      end
    end
    params[:rate][:origin_location_id] = @origin_location_id
    if params[:rate][:destination_location_id].present? || params[:rate][:destination_address].present? ||  params[:rate][:destination_country].present? ||  params[:rate][:destination_state].present? ||  params[:rate][:destination_postal].present? ||  params[:rate][:destination_city].present?
      if params[:destination_new_location].present?
        location = Location.new
        location.address = params[:rate][:destination_address]
        location.country = params[:rate][:destination_country]
        location.state = params[:rate][:destination_state]
        location.city = params[:rate][:destination_city]
        location.postal = params[:rate][:destination_postal]
        location.save
        @destination_location_id = location.id
      else
        @destination_location_id =  params[:rate][:destination_location_id]
      end
    end
    params[:rate][:destination_location_id] = @destination_location_id
    respond_to do |format|
      if @rate.update(rate_params)
        if params[:rate][:supporting_pdf].present?
          @rate.supporting_pdf.attach(params[:rate][:supporting_pdf])
        end
        format.html { redirect_to @rate, notice: 'Rate was successfully updated.' }
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
      format.html { redirect_to rates_url, notice: 'Rate was successfully destroyed.' }
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
      params.require(:rate).permit(:client_id, :rate_type, :parent_id, :rate_level, :rep_id, :effective_to, :effective_from, :origin_location_id, :destination_location_id, :freight_desc, :freight_classification, :transit_time, :minimum_density)
    end
end
