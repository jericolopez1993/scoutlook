class MasterSignalsController < ApplicationController
  before_action :set_master_signal, only: [:show, :edit, :update, :destroy]

  # GET /master_signals
  # GET /master_signals.json
  def index
    @master_signals = MasterSignal.all
    authorize @master_signals
  end

  # GET /master_signals/1
  # GET /master_signals/1.json
  def show
  end

  # GET /master_signals/new
  def new
    @master_signal = MasterSignal.new
    authorize @master_signal
  end

  # GET /master_signals/1/edit
  def edit
  end

  # POST /master_signals
  # POST /master_signals.json
  def create
    @master_signal = MasterSignal.new(master_signal_params)
    if params[:master_signal][:origin_location_id].present? || params[:master_signal][:origin_address].present? || params[:master_signal][:origin_country].present? ||  params[:master_signal][:origin_state].present? ||  params[:master_signal][:origin_postal].present? ||  params[:master_signal][:origin_city].present?
      if params[:origin_new_location].present?
        location = Location.new
        location.address = params[:master_signal][:origin_address]
        location.country = params[:master_signal][:origin_country]
        location.state = params[:master_signal][:origin_state]
        location.city = params[:master_signal][:origin_city]
        location.postal = params[:master_signal][:origin_postal]
        location.save
        @origin_location_id = location.id
      else
        @origin_location_id =  params[:master_signal][:origin_location_id]
      end
    end
    @master_signal.origin_location_id = @origin_location_id
    if params[:master_signal][:destination_location_id].present? || params[:master_signal][:destination_address].present? ||  params[:master_signal][:destination_country].present? ||  params[:master_signal][:destination_state].present? ||  params[:master_signal][:destination_postal].present? ||  params[:master_signal][:destination_city].present?
      if params[:destination_new_location].present?
        location = Location.new
        location.address = params[:master_signal][:destination_address]
        location.country = params[:master_signal][:destination_country]
        location.state = params[:master_signal][:destination_state]
        location.city = params[:master_signal][:destination_city]
        location.postal = params[:master_signal][:destination_postal]
        location.save
        @destination_location_id = location.id
      else
        @destination_location_id =  params[:master_signal][:destination_location_id]
      end
    end
    @master_signal.destination_location_id = @destination_location_id
    respond_to do |format|
      if @master_signal.save
        format.html { redirect_to @master_signal, notice: 'Master signal was successfully created.' }
        format.json { render :show, status: :created, location: @master_signal }
      else
        format.html { render :new }
        format.json { render json: @master_signal.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /master_signals/1
  # PATCH/PUT /master_signals/1.json
  def update
    if params[:master_signal][:origin_location_id].present? || params[:master_signal][:origin_address].present? || params[:master_signal][:origin_country].present? ||  params[:master_signal][:origin_state].present? ||  params[:master_signal][:origin_postal].present? ||  params[:master_signal][:origin_city].present?
      if params[:origin_new_location].present?
        location = Location.new
        location.address = params[:master_signal][:origin_address]
        location.country = params[:master_signal][:origin_country]
        location.state = params[:master_signal][:origin_state]
        location.city = params[:master_signal][:origin_city]
        location.postal = params[:master_signal][:origin_postal]
        location.save
        @origin_location_id = location.id
      else
        @origin_location_id =  params[:master_signal][:origin_location_id]
      end
    end
    params[:master_signal][:origin_location_id] = @origin_location_id
    if params[:master_signal][:destination_location_id].present? || params[:master_signal][:destination_address].present? ||  params[:master_signal][:destination_country].present? ||  params[:master_signal][:destination_state].present? ||  params[:master_signal][:destination_postal].present? ||  params[:master_signal][:destination_city].present?
      if params[:destination_new_location].present?
        location = Location.new
        location.address = params[:master_signal][:destination_address]
        location.country = params[:master_signal][:destination_country]
        location.state = params[:master_signal][:destination_state]
        location.city = params[:master_signal][:destination_city]
        location.postal = params[:master_signal][:destination_postal]
        location.save
        @destination_location_id = location.id
      else
        @destination_location_id =  params[:master_signal][:destination_location_id]
      end
    end
    params[:master_signal][:destination_location_id] = @destination_location_id
    respond_to do |format|
      if @master_signal.update(master_signal_params)
        format.html { redirect_to @master_signal, notice: 'Master signal was successfully updated.' }
        format.json { render :show, status: :ok, location: @master_signal }
      else
        format.html { render :edit }
        format.json { render json: @master_signal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /master_signals/1
  # DELETE /master_signals/1.json
  def destroy
    @master_signal.destroy
    respond_to do |format|
      format.html { redirect_to master_signals_url, notice: 'Master signal was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_master_signal
      @master_signal = MasterSignal.find(params[:id])
      authorize @master_signal
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def master_signal_params
      params[:master_signal][:signal_date] = Date::strptime(params[:master_signal][:signal_date], "%m/%d/%Y")
      params[:master_signal][:start_date] = Date::strptime(params[:master_signal][:start_date], "%m/%d/%Y")
      params[:master_signal][:end_date] = Date::strptime(params[:master_signal][:end_date], "%m/%d/%Y")
      params.require(:master_signal).permit(:signal_type, :signal_date, :client_id, :client_contact_id, :rate_id, :origin_location_id, :destination_location_id, :start_date, :end_date, :duration, :volume, :uom, :per, :capacity_type, :max_origin, :max_destination, :desired_rate, :notes, :same_hoc)
    end
end
