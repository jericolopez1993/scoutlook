class RemindersController < ApplicationController
  before_action :set_reminder, only: [:show, :edit, :update, :destroy]
  before_action :set_previous_controller, only: [:show, :edit, :update, :destroy, :new]

  # GET /reminders
  # GET /reminders.json
  def index
    respond_to do |format|
      format.html
      format.json { render json: ReminderDatatable.new(params, view_context: view_context) }
    end
    # if current_user.has_role?(:admin)
    #   @reminders = Reminder.listings
    # else
    #   @reminders = Reminder.listings.where("user_id = ?", current_user.id)
    # end
  end

  # GET /reminders/1
  # GET /reminders/1.json
  def show
  end

  # GET /reminders/new
  def new
    @reminder = Reminder.new
    if @previous_controller == "carriers"
      @reminder.carrier_id = params[:id]
    elsif @previous_controller == "shippers"
      @reminder.shipper_id = params[:id]
    elsif @previous_controller == "activities"
      @reminder.activity_id = params[:id]
    end
  end

  # GET /reminders/1/edit
  def edit
  end

  # POST /reminders
  # POST /reminders.json
  def create
    @reminder = Reminder.new(reminder_params)

    respond_to do |format|
      if @reminder.save
        ComputeDataService.new.next_reminder_date(@reminder)
        format.html { redirect_to @reminder, notice: 'Reminder was successfully created.' }
        format.json { render :show, status: :created, location: @reminder }
      else
        format.html { render :new }
        format.json { render json: @reminder.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reminders/1
  # PATCH/PUT /reminders/1.json
  def update
    respond_to do |format|
      if @reminder.update(reminder_params)
        ComputeDataService.new.next_reminder_date(@reminder)
        format.html { redirect_to @reminder, notice: 'Reminder was successfully updated.' }
        format.json { render :show, status: :ok, location: @reminder }
      else
        format.html { render :edit }
        format.json { render json: @reminder.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reminders/1
  # DELETE /reminders/1.json
  def destroy
    if @reminder.destroy
      if @reminder.carrier_id
        carrier = Carrier.find(@reminder.carrier_id)
        if carrier.c_reminder_id == @reminder.id
          carrier.update_attributes(
            :c_reminder_id => nil,
            :c_reminder_date => nil,
            :c_reminder_interval => nil,
            :c_reminder_notes => nil,
            :c_reminder_type => nil
          )
        end
      end

      respond_to do |format|
        if @previous_controller == "carriers"
          format.html { redirect_to carrier_path(:id => @reminder.carrier_id), notice: 'Reminder was successfully removed.' }
        elsif @previous_controller == "shippers"
          format.html { redirect_to shipper_path(:id => @reminder.shipper_id), notice: 'Reminder was successfully removed.' }
        else
          format.html { redirect_to reminders_url, notice: 'Reminder was successfully removed.' }
        end
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reminder
      @reminder = Reminder.listings.find(params[:id])
    end

    def set_previous_controller
      if params[:previous_controller].present?
        @previous_controller = params[:previous_controller]
      else
        @previous_controller = 'reminders'
      end
      if @previous_controller == "reminders"
        @client_type = params[:client_type]
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reminder_params
      if params[:reminder][:reminder_date].present?
        params[:reminder][:reminder_date] = Time.zone.strptime(params[:reminder][:reminder_date], '%m/%d/%Y %l:%M %p')
      else
        params[:reminder][:reminder_date] = nil
      end

      if params[:reminder][:notes].present?
        params[:reminder][:notes] = params[:reminder][:notes].gsub("'", '&#39;')
      end
      params[:reminder][:user_id] = current_user.id
      params.require(:reminder).permit(:carrier_id, :shipper_id, :activity_id, :user_id, :reminder_date, :reminder_interval, :recurring, :notes, :reminder_type, :completed)
    end
end
