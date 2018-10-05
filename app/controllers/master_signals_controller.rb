class MasterSignalsController < ApplicationController
  before_action :set_master_signal, only: [:show, :edit, :update, :destroy]

  # GET /master_signals
  # GET /master_signals.json
  def index
    @master_signals = MasterSignal.all
  end

  # GET /master_signals/1
  # GET /master_signals/1.json
  def show
  end

  # GET /master_signals/new
  def new
    @master_signal = MasterSignal.new
  end

  # GET /master_signals/1/edit
  def edit
  end

  # POST /master_signals
  # POST /master_signals.json
  def create
    @master_signal = MasterSignal.new(master_signal_params)

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
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def master_signal_params
      params.require(:master_signal).permit(:signal_type, :signal_date, :client_id, :client_contact_id, :rate_id, :origin_city, :origin_state, :origin_country, :destination_city, :destination_state, :destination_country, :start_date, :end_date, :duration, :volume, :uom, :per, :capacity_type, :max_origin, :max_destination, :desired_rate, :notes, :same_hoc)
    end
end
