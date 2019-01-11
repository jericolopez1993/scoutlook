class ShippersController < ApplicationController
  include ApplicationHelper
  before_action :set_shipper, only: [:show, :edit, :update, :destroy, :remove_attachment]

  # GET /shippers
  # GET /shippers.json
  def index
    if !user_signed_in?
      redirect_to(unauthenticated_root_path)
    else
      @shippers = []
      if current_user.has_role?(:admin)
        @shippers = Shipper.all
        authorize @shippers
      elsif current_user.has_role?(:steward) || current_user.ro || current_user.cs
        @shippers = Shipper.where(:relationship_owner => current_user.id)
        authorize @shippers
      elsif current_user.has_role?(:contact)
        begin
          @shipper = Shipper.find(current_user.shipper_contact.shipper.id)
          redirect_to @shipper
        rescue
          @shippers = []
        end
      end
    end
  end

  # GET /shippers/1
  # GET /shippers/1.json
  def show
  end

  # GET /shippers/new
  def new
    @shipper = Shipper.new
    if user_signed_in?
      if current_user.ro
        @shipper.relationship_owner = current_user.id
      end
    end
    authorize @shipper
  end

  # GET /shippers/1/edit
  def edit
  end

  # POST /shippers
  # POST /shippers.json
  def create
    @shipper = Shipper.new(shipper_params)
    respond_to do |format|
      if @shipper.save
        @location = ShipperLocation.new(location_params)
        @location.shipper_id = @shipper.id
        if @location.save
          @shipper.update_attributes(:head_office => @location.id)
        end
        if params[:shipper][:attachment_file].present?
          @shipper.attachment_file.attach(params[:shipper][:attachment_file])
        end

        format.html { redirect_to @shipper, notice: 'Shipper was successfully created.' }
        format.json { render :show, status: :created, location: @shipper }
      else
        format.html { render :new }
        format.json { render json: @shipper.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /shippers/1
  # PATCH/PUT /shippers/1.json
  def update
    respond_to do |format|
      if params[:shipper][:attachment_only].present?
        if params[:shipper][:attachment_file].present?
          @shipper.attachment_file.attach(params[:shipper][:attachment_file])
          @shipper.update_attributes!(audit_comment: "Attachment")
        end
        format.html { redirect_to @shipper, notice: 'Shipper was successfully updated.' }
        format.json { render :show, status: :ok, location: @shipper }
      else
        if @shipper.update(shipper_params)
          if @shipper.location.nil?
            @location = ShipperLocation.new(location_params)
            @location.shipper_id = @shipper.id
            if @location.save
              @shipper.update_attributes(:head_office => @location.id)
            end
          else
            @shipper.location.update_attributes(location_params)
          end

          if params[:shipper][:attachment_file].present?
            @shipper.attachment_file.attach(params[:shipper][:attachment_file])
          end
          format.html { redirect_to @shipper, notice: 'Shipper was successfully updated.' }
          format.json { render :show, status: :ok, location: @shipper }
        else
          format.html { render :edit }
          format.json { render json: @shipper.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /shippers/1
  # DELETE /shippers/1.json
  def destroy
    @shipper.destroy
    respond_to do |format|
      format.html { redirect_to shippers_url, notice: 'Shipper was successfully removed.' }
      format.json { head :no_content }
    end
  end

  def origins
    if  params[:shipper_id].present?
      shipper = Shipper.find(params[:shipper_id])
      render json: {:shipper_id => shipper.id, :origins => shipper.origin}
    else
      render json: {:shipper_id => nil, :origins => nil}
    end

  end

  def remove_attachment
    respond_to do |format|
      if @shipper.attachment_file.find(params[:attachment_id]).purge
        format.html { redirect_to shipper_path(:id => @shipper.id), notice: 'Attachment Successfully Removed.' }
        format.json { render :show, status: :ok, location: @shipper }
      else
        format.html { redirect_to shipper_path(:id => @shipper.id), error: 'Attachment Remove Failed.' }
        format.json { render json: @shipper.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shipper
      @shipper = Shipper.find(params[:id])
      authorize @shipper
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def shipper_params
      params[:shipper][:shipper_type] = convert_array(params[:shipper][:shipper_type])
      params[:shipper][:commodities] = convert_array(params[:shipper][:commodities])
      params.require(:shipper).permit(:relationship_owner, :company_name, :shipper_id, :parent_id, :sales_priority, :phone, :annual_revenue, :industry, :primary_industry, :hazardous, :food_grade, :freight_revenue, :volume_intra, :volume_inter, :volume_to_usa, :volume_from_usa, :notes, :credit_status, :credit_approval, :shipper_type, :control_freight, :loads_per_month, :spend_per_year, :commodities, :commodities_notes, :blue_book_score, :blue_book_url, :buying_criteria, :works_with_brokers, :price_sensitivity, :challenges, :current_carrier_mix, :prefer_teams, :years_in_business, :complete_record, :website, :linkedin, :last_contact, :last_contact_by, :load_last_month, :load_last_6_month, :loads_per_month, :approved)
    end

    def location_params
      params[:shipper][:is_origin] = params[:origin].present?
      params[:shipper][:is_destination] = params[:destination].present?
      params[:shipper][:name] = params[:shipper][:location_name]
      params.require(:shipper).permit(:name, :address, :country, :state, :city, :postal, :is_origin, :is_destination, :loc_type, :phone)
    end
end
