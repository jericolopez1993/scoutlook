class CarriersController < ApplicationController
  include ApplicationHelper
  before_action :set_carrier, only: [:show, :edit, :update, :destroy, :remove_attachment]

  # GET /carriers
  # GET /carriers.json
  def index
    begin
      if current_user.has_role?(:admin)
        @carriers = Carrier.all
        authorize @carriers
      elsif current_user.has_role?(:steward)
        if current_user.steward.nil?
          @carriers = []
        else
        @carriers = Carrier.where(:relationship_owner => current_user.steward.id)
        authorize @carriers
        end
      elsif current_user.has_role?(:contact)
        begin
          @carrier = Carrier.find(current_user.carrier_contact.carrier.id)
          redirect_to @carrier
        rescue
          @carriers = nil
        end
      end
    rescue
      @carriers = nil
    end
  end

  # GET /carriers/1
  # GET /carriers/1.json
  def show
  end

  # GET /carriers/new
  def new
    @carrier = Carrier.new
    begin
      if current_user.has_role?(:steward) && !current_user.steward.nil?
        @carrier.relationship_owner = current_user.steward.id
      end
    rescue
    end
    authorize @carrier
  end

  # GET /carriers/1/edit
  def edit
  end

  # POST /carriers
  # POST /carriers.json
  def create
    @carrier = Carrier.new(carrier_params)
    respond_to do |format|
      if @carrier.save
        @location = CarrierLocation.new(location_params)
        @location.carrier_id = @carrier.id
        if @location.save
          @carrier.update_attributes(:head_office => @location.id)
        end
        if params[:carrier][:attachment_file].present?
          @carrier.attachment_file.attach(params[:carrier][:attachment_file])
        end

        format.html { redirect_to @carrier, notice: 'Carrier was successfully created.' }
        format.json { render :show, status: :created, location: @carrier }
      else
        format.html { render :new }
        format.json { render json: @carrier.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /carriers/1
  # PATCH/PUT /carriers/1.json
  def update
    respond_to do |format|
      if params[:carrier][:attachment_only].present?
        if params[:carrier][:attachment_file].present?
          @carrier.attachment_file.attach(params[:carrier][:attachment_file])
          @carrier.update_attributes!(audit_comment: "Attachment")
        end
        format.html { redirect_to @carrier, notice: 'Carrier was successfully updated.' }
        format.json { render :show, status: :ok, location: @carrier }
      else
        if @carrier.update(carrier_params)
          if @carrier.location.nil?
            @location = CarrierLocation.new(location_params)
            @location.carrier_id = @carrier.id
            if @location.save
              @carrier.update_attributes(:head_office => @location.id)
            end
          else
            @carrier.location.update_attributes(location_params)
          end

          if params[:carrier][:attachment_file].present?
            @carrier.attachment_file.attach(params[:carrier][:attachment_file])
          end
          format.html { redirect_to @carrier, notice: 'Carrier was successfully updated.' }
          format.json { render :show, status: :ok, location: @carrier }
        else
          format.html { render :edit }
          format.json { render json: @carrier.errors, status: :unprocessable_entity }
        end
      end
    end
  end


  # DELETE /carriers/1
  # DELETE /carriers/1.json
  def destroy
    @carrier.destroy
    respond_to do |format|
      format.html { redirect_to carriers_url, notice: 'Carrier was successfully removed.' }
      format.json { head :no_content }
    end
  end

  def origins
    if  params[:carrier_id].present?
      carrier = Carrier.find(params[:carrier_id])
      render json: {:carrier_id => carrier.id, :origins => carrier.origin}
    else
      render json: {:carrier_id => nil, :origins => nil}
    end

  end

  def remove_attachment
    respond_to do |format|
      if @carrier.attachment_file.find(params[:attachment_id]).purge
        format.html { redirect_to carrier_path(:id => @carrier.id), notice: 'Attachment Successfully Removed.' }
        format.json { render :show, status: :ok, location: @carrier }
      else
        format.html { redirect_to carrier_path(:id => @carrier.id), error: 'Attachment Remove Failed.' }
        format.json { render json: @carrier.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_carrier
      @carrier = Carrier.find(params[:id])
      authorize @carrier
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def carrier_params
      params[:carrier][:complete_record] = params[:complete_record].present?
      params[:carrier][:approved] = params[:approved].present?
      if params[:carrier][:last_contact].present?
        params[:carrier][:last_contact] = Date::strptime(params[:carrier][:last_contact], "%m/%d/%Y")
      else
        params[:carrier].delete :last_contact
      end
      params.require(:carrier).permit(:relationship_owner, :company_name, :carrier_id, :parent_id, :sales_priority, :phone, :annual_revenue, :industry, :primary_industry, :hazardous, :food_grade, :freight_revenue, :volume_intra, :volume_inter, :volume_to_usa, :volume_from_usa, :notes, :credit_status, :credit_approval, :score_card, :freight_guard, :years_in_business, :owner_operators, :reefers, :dry_vans, :flat_beds, :teams, :contract_rates, :find_loads, :complete_record, :total_fleet_size, :website, :linkedin, :last_contact, :last_contact_by, :power_units, :company_drivers, :load_last_month, :load_last_6_month, :approved, :mc_number)
    end

    def location_params
      params[:carrier][:is_origin] = params[:origin].present?
      params[:carrier][:is_destination] = params[:destination].present?
      params[:carrier][:name] = params[:carrier][:location_name]
      params.require(:carrier).permit(:name, :address, :country, :state, :city, :postal, :is_origin, :is_destination, :loc_type, :phone)
    end
end
