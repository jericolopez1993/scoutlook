class CarrierNotesController < ApplicationController
  before_action :set_carrier_note, only: [:show, :edit, :update, :destroy]

  # GET /carrier_notes
  # GET /carrier_notes.json
  def index
    @carrier_notes = CarrierNote.all
  end

  # GET /carrier_notes/1
  # GET /carrier_notes/1.json
  def show
  end

  # GET /carrier_notes/new
  def new
    @carrier_note = CarrierNote.new
  end

  # GET /carrier_notes/1/edit
  def edit
  end

  # POST /carrier_notes
  # POST /carrier_notes.json
  def create
    @carrier_note = CarrierNote.new(carrier_note_params)
    respond_to do |format|
      if @carrier_note.save
        format.html { redirect_to carrier_path(:id => @carrier_note.carrier_id), notice: 'Carrier Note was successfully created.' }
        format.json { render :show, status: :created, location: @carrier_note }
      else
        format.html { redirect_to carrier_path(:id => @carrier_note.carrier_id) }
        format.json { render json: @carrier_note.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /carrier_notes/1
  # PATCH/PUT /carrier_notes/1.json
  def update
    respond_to do |format|
      if @carrier_note.update(carrier_note_params)
        format.html { redirect_to carrier_path(:id => @carrier_note.carrier_id), notice: 'Carrier Note was successfully updated.' }
        format.json { render :show, status: :ok, location: @carrier_note }
      else
        format.html { redirect_to carrier_path(:id => @carrier_note.carrier_id) }
        format.json { render json: @carrier_note.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /carrier_notes/1
  # DELETE /carrier_notes/1.json
  def destroy
    @carrier_note.destroy
    respond_to do |format|
      format.html { redirect_to carrier_path(:id => @carrier_note.carrier_id), notice: 'Carrier Note was successfully removed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_carrier_note
      @carrier_note = CarrierNote.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def carrier_note_params
      params.require(:carrier_note).permit(:notes, :carrier_id, :user_id)
    end
end
