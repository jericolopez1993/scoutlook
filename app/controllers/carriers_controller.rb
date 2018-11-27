class CarriersController < ApplicationController
  include ApplicationHelper
  before_action :set_carrier, only: [:show, :edit, :update, :destroy, :remove_attachment]

  # GET /carriers
  # GET /carriers.json
  def index
    @carriers = Carrier.all
    authorize @carriers
  end

  # GET /carriers/1
  # GET /carriers/1.json
  def show
  end

  # GET /carriers/new
  def new
    @carrier = Carrier.new
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
      if @carrier.update(carrier_params)
        if params[:origin].present? || params[:destination].present? || params[:carrier][:location_name].present? || params[:carrier][:state].present? || params[:carrier][:city].present?
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

  # DELETE /carriers/1
  # DELETE /carriers/1.json
  def destroy
    @carrier.destroy
    respond_to do |format|
      format.html { redirect_to carriers_url, notice: 'Carrier was successfully destroyed.' }
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
      params.require(:carrier).permit(:relationship_owner, :company_name, :carrier_id, :parent_id, :sales_priority, :phone, :annual_revenue, :industry, :primary_industry, :hazardous, :food_grade, :freight_revenue, :volume_intra, :volume_inter, :volume_to_usa, :volume_from_usa, :notes, :credit_status, :credit_approval, :score_card, :freight_guard, :years_in_business, :owner_operators, :reefers, :dry_vans, :flat_beds, :teams, :contract_rates, :find_loads, :complete_record, :total_fleet_size, :website, :linkedin)
    end

    def location_params
      params[:carrier][:is_origin] = params[:origin].present?
      params[:carrier][:is_destination] = params[:destination].present?
      params[:carrier][:name] = params[:carrier][:location_name]
      params.require(:carrier).permit(:name, :address, :country, :state, :city, :postal, :is_origin, :is_destination, :loc_type, :phone)
    end
end
