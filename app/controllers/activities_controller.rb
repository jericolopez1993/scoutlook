class ActivitiesController < ApplicationController
  before_action :set_activity, only: [:show, :edit, :update, :destroy, :remove_attachment, :generate_pdf]
  before_action :set_body, only: [:generate_pdf]
  before_action :set_previous_controller, only: [:show, :edit, :update, :destroy, :new]

  # GET /activities
  # GET /activities.json
  def index
    @activities = Activity.all
    authorize @activities
  end

  # GET /activities/1
  # GET /activities/1.json
  def show
  end

  # GET /activities/new
  def new
    @activity = Activity.new
    if params[:carrier_id].present?
      @activity.carrier_id = params[:carrier_id]
    elsif params[:shipper_id].present?
      @activity.shipper_id = params[:shipper_id]
    end

    authorize @activity
  end

  # GET /activities/1/edit
  def edit
  end

  # POST /activities
  # POST /activities.json
  def create
    @activity = Activity.new(activity_params)
    @activity.user_id = current_user.id
    respond_to do |format|
      if @activity.save
        if params[:activity][:proposal_pdf].present?
          @activity.proposal_pdf.attach(params[:activity][:proposal_pdf])
        end
        if params[:activity][:credit_application].present?
          @activity.credit_application.attach(params[:activity][:credit_application])
        end
        if params[:activity][:previous_params] != "activities"
          if !@activity.carrier.nil?
            format.html { redirect_to carrier_path(:id => @activity.carrier_id), notice: 'Activity was successfully created.' }
          elsif !@activity.shipper.nil?
            format.html { redirect_to shipper_path(:id => @activity.shipper_id), notice: 'Activity was successfully created.' }
          else
            format.html { redirect_to activities_path, notice: 'Activity was successfully created.' }
          end
        else
          format.html { redirect_to activities_path, notice: 'Activity was successfully created.' }
        end
        format.json { render :show, status: :created, location: @activity }
      else
        format.html { render :new }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /activities/1
  # PATCH/PUT /activities/1.json
  def update
    respond_to do |format|
      if @activity.update(activity_params)
        if params[:activity][:proposal_pdf].present?
          @activity.proposal_pdf.attach(params[:activity][:proposal_pdf])
        end
        if params[:activity][:credit_application].present?
          @activity.credit_application.attach(params[:activity][:credit_application])
        end
        if params[:activity][:previous_params] != "activities"
          if !@activity.carrier.nil?
            format.html { redirect_to carrier_path(:id => @activity.carrier_id), notice: 'Activity was successfully updated.' }
          elsif !@activity.shipper.nil?
            format.html { redirect_to shipper_path(:id => @activity.shipper_id), notice: 'Activity was successfully updated.' }
          else
            format.html { redirect_to activities_path, notice: 'Activity was successfully updated.' }
          end
        else
          format.html { redirect_to activities_path, notice: 'Activity was successfully updated.' }
        end
        format.json { render :show, status: :ok, location: @activity }
      else
        format.html { render :edit }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /activities/1
  # DELETE /activities/1.json
  def destroy
    @activity.destroy
    respond_to do |format|
      if @previous_controller == "carriers"
        format.html { redirect_to carrier_path(:id => @activity.carrier_id), notice: 'Activity was successfully removed.' }
      elsif @previous_controller == "shippers"
        format.html { redirect_to shipper_path(:id => @activity.shipper_id), notice: 'Activity was successfully removed.' }
      else
        format.html { redirect_to activities_path, notice: 'Activity was successfully removed.' }
      end
      format.json { head :no_content }
    end
  end

  def quick_create
    @activity = Activity.new(activity_params)
    respond_to do |format|
      if @activity.save
        if params[:activity][:proposal_pdf].present?
          @activity.proposal_pdf.attach(params[:activity][:proposal_pdf])
        end
        if params[:activity][:credit_application].present?
          @activity.credit_application.attach(params[:activity][:credit_application])
        end
        format.html { redirect_to authenticated_root_path, notice: 'Activity was successfully created.' }
        format.json { render :show, status: :created, location: @activity }
      else
        format.html { render :new }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end

  def remove_attachment
    respond_to do |format|
      if @activity.proposal_pdf.find(params[:attachment_id]).purge
        format.html { redirect_to carrier_path(:id => carrier.id), notice: 'Attachment Successfully Removed.' }
        format.json { render :show, status: :ok, location: @activity }
      else
        format.html { redirect_to activity_path(:id => @activity.id), error: 'Attachment Remove Failed.' }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end

  def generate_pdf
    require "pdfkit"
    kit = PDFKit.new(@content)
    send_data(kit.to_pdf,filename: "#{@activity.display_select_name}.pdf",type: "application/pdf",)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_activity
      @activity = Activity.find(params[:id])
      authorize @activity
    end

    def set_body
      @style = "<style>
                      .header {
                        text-align: center;
                        color: #000;
                        margin-bottom: -15px;
                      }
                      .sub-header {
                        text-align: center;
                        color: #ee9c10;
                        margin-bottom: 50px;
                      }
                      .header-logo {
                        width: 200px;
                        vertical-align: middle;
                      }
                      tr>td {
                        font-size: 18px;
                        padding-bottom: 1em;
                      }
                      .carrier {
                        color: #6f060b;
                      }
                      .shipper {
                        color: #013a38;
                      }
                      .none {
                        color: #999;
                      }
                </style>"

      @content = "<tr>
                    <td><b>Owner:</b> <span>#{@activity.user ? @activity.user.full_name : ''}</span></td>
                  </tr>
                  <tr>
                    <td><b>Type:</b> <span>#{@activity.activity_type}</span></td>
                  </tr>
                  <tr>
                    <td><b>Status:</b> <span>#{@activity.status ? 'Open' : 'Closed'}</span></td>
                  </tr>
                  <tr>
                    <td><b>LPW:</b> <span>#{@activity.loads_per_week}</span></td>
                  </tr>
                  <tr>
                    <td><b>Annual:</b> <span>#{@activity.annual_value}</span></td>
                  </tr>
                  <tr>
                    <td><b>Date Open:</b> <span>#{@activity.date_opened}</span></td>
                  </tr>
                  <tr>
                    <td><b>Date Close:</b> <span>#{@activity.date_closed}</span></td>
                  </tr>
                  <tr>
                    <td><b>Outcome:</b> <span>#{@activity.outcome}</span></td>
                  </tr>
                  <tr>
                    <td><b>Reason:</b> <span>#{!@activity.reason.blank? ? @activity.reason : '<span class=none>None</span>'}</span></td>
                  </tr>
                  <tr>
                    <td><hr></td>
                  </tr>"

      if !@activity.carrier.nil?
        @content = @content +
                   "<tr>
                     <td><b>Carrier:</b> <strong class='carrier'>#{@activity.carrier ? @activity.carrier.company_name : ''}</strong></td>
                    </tr>
                    <tr>
                      <td><b>Contact Activity:</b> <span>#{@activity.carrier_contact.nil? ? '<span class=none>None</span>' : @activity.carrier_contact.full_name}</span></td>
                    </tr>
                    <tr>
                      <td><b>Priority:</b> <span>#{@activity.carrier.nil? || @activity.carrier.sales_priority.blank? ? '<span class=none>None</span>' : @activity.carrier.sales_priority}</span></td>
                    </tr>
                    <tr>
                      <td><b>City:</b> <span>#{@activity.carrier.nil? || @activity.carrier.head_office_location.city.blank? ? '<span class=none>None</span>' : @activity.carrier.head_office_location.city}</span></td>
                    </tr>
                    <tr>
                      <td><b>State:</b> <span>#{@activity.carrier.nil? || @activity.carrier.head_office_location.state.blank? ? '<span class=none>None</span>' : @activity.carrier.head_office_location.state}</span></td>
                    </tr>
                    <tr>
                      <td><hr></td>
                    </tr>
                    <tr>
                      <td><b>Notes:</b> <span>#{@activity.notes.blank? ? "<span class=none>None</span>" : @activity.notes.html_safe}</span></td>
                    </tr>"
      elsif !@activity.shipper.nil?
        @content = @content +
                   "<tr>
                     <td><b>Shipper:</b> <strong class='shipper'>#{@activity.shipper ? @activity.shipper.company_name : ''}</strong></td>
                    </tr>
                    <tr>
                      <td><b>Contact Activity:</b> <span>#{@activity.shipper_contact.nil? ? '<span class=none>None</span>' : @activity.shipper_contact.full_name}</span></td>
                    </tr>
                    <tr>
                      <td><b>Priority:</b> <span>#{@activity.shipper.blank? || @activity.shipper.sales_priority.blank? ? '<span class=none>None</span>' : @activity.shipper.sales_priority}</span></td>
                    </tr>
                    <tr>
                      <td><b>City:</b> <span>#{@activity.shipper.nil? || @activity.shipper.head_office_location.city.blank? ? '<span class=none>None</span>' : @activity.shipper.head_office_location.city}</span></td>
                    </tr>
                    <tr>
                      <td><b>State:</b> <span>#{@activity.shipper.nil? || @activity.shipper.head_office_location.state.blank? ? '<span class=none>None</span>' : @activity.shipper.head_office_location.state}</span></td>
                    </tr>
                    <tr>
                      <td><hr></td>
                    </tr>
                    <tr>
                      <td><b>Notes:</b> <span>#{@activity.notes.blank? ? "<span class=none>None</span>" : @activity.notes.html_safe}</span></td>
                    </tr>"
      else
        @content = @content +
                   "<tr>
                     <td><b>Notes:</b> <span>#{@activity.notes.blank? ? "<span class=none>None</span>" : @activity.notes.html_safe}</span></td>
                   </tr>"
      end

      @content = @style +
                 "<div>" +
                    "<h1 class='header'><img class='header-logo' src='https://scoutlook.ca/assets/Scoutlook_Logo_red-9899a10bfe6dff35407ad6c1a6fd366b02035573e1567ba004147d0d01220ccd.png'> <span style='vertical-align: middle;'></h1>" +
                    "<h3 class='sub-header'>(Activity)</h3>" +
                    "<table width=100%>" +
                      "<tbody>" +
                        @content +
                      "</tbody>" +
                    "</table>" +
                  "</div>"

    end

    def set_previous_controller
      if params[:previous_controller].present?
        @previous_controller = params[:previous_controller]
      else
        @previous_controller = 'activities'
      end

      if @previous_controller == "activities"
        @client_type = params[:client_type]
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def activity_params
      params.require(:activity).permit(:outcome, :reason, :reason_other, :notes, :date_stamp, :activity_type, :engagement_type, :carrier_id, :carrier_contact_id, :shipper_id, :shipper_contact_id, :user_id, :annual_value, :loads_per_week, :status, :date_opened, :date_closed, :other_notes, :outcome_id, :campaign_name, :load_numbers)
    end

end
