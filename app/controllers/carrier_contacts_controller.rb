class CarrierContactsController < ApplicationController
  include ApplicationHelper
  before_action :set_carrier_contact, only: [:show, :edit, :update, :destroy]

  # GET /carrier_contacts
  # GET /carrier_contacts.json
  def index
    @carrier_contacts = CarrierContact.all
    authorize @carrier_contacts
  end

  # GET /carrier_contacts/1
  # GET /carrier_contacts/1.json
  def show
  end

  # GET /carrier_contacts/new
  def new
    @carrier_contact = CarrierContact.new
    if params[:carrier_id].present?
      @carrier_contact.carrier_id = params[:carrier_id]
    end
    authorize @carrier_contact
  end

  # GET /carrier_contacts/1/edit
  def edit
    carrier = Carrier.find(@carrier_contact.carrier_id)
    @is_pdm = carrier.pdm_id == @carrier_contact.id
    @is_poc = carrier.poc_id == @carrier_contact.id
  end

  # POST /carrier_contacts
  # POST /carrier_contacts.json
  def create
    @carrier_contact = CarrierContact.new(carrier_contact_params)
    params.require(:carrier_contact).permit(:first_name, :last_name, :email, :password, :password_confirmation)
    if params[:same_ho].present?
      @carrier_contact.same_ho = true
    else
      @carrier_contact.same_ho = false
    end
    @location_id = nil
    if params[:carrier_contact][:location_id].present? || params[:carrier_contact][:address].present? || params[:carrier_contact][:country].present? ||  params[:carrier_contact][:state].present? ||  params[:carrier_contact][:postal].present? ||  params[:carrier_contact][:city].present?
      if is_numeric?(params[:carrier_contact][:location_id])
          @location_id = params[:carrier_contact][:location_id]
      else
        location = CarrierLocation.new
        location.name = params[:carrier_contact][:location_id]
        location.address = params[:carrier_contact][:address]
        location.country = params[:carrier_contact][:country]
        location.state = params[:carrier_contact][:state]
        location.city = params[:carrier_contact][:city]
        location.postal = params[:carrier_contact][:postal]
        location.carrier_id = params[:carrier_contact][:carrier_id]
        location.save
        @location_id = location.id
      end
    end
    @carrier_contact.location_id =  @location_id
    respond_to do |format|
      if @carrier_contact.save
        if params[:carrier_contact][:email].present? && params[:carrier_contact][:password].present? && params[:carrier_contact][:password_confirmation].present?
          @user = User.new(user_params)
          @user.carrier_contact_id = @carrier_contact.id
          @user.skip_confirmation!
          if @user.save
            @user.add_role :contact
          end
        end
        carrier = Carrier.find(@carrier_contact.carrier_id)
        if params[:pdm].present?
          carrier.update_attributes(:pdm_id => @carrier_contact.id)
        end
        if params[:poc].present?
          carrier.update_attributes(:poc_id => @carrier_contact.id)
        end
        format.html { redirect_to carrier_path(:id => carrier.id), notice: 'Carrier contact was successfully created.' }
        format.json { render :show, status: :created, location: @carrier_contact }
      else
        format.html { render :new }
        format.json { render json: @carrier_contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /carrier_contacts/1
  # PATCH/PUT /carrier_contacts/1.json
  def update
    @location_id = nil
    if params[:carrier_contact][:location_id].present? || params[:carrier_contact][:address].present? || params[:carrier_contact][:country].present? ||  params[:carrier_contact][:state].present? ||  params[:carrier_contact][:postal].present? ||  params[:carrier_contact][:city].present?
      if is_numeric?(params[:carrier_contact][:location_id])
          @location_id = params[:carrier_contact][:location_id]
      else
        location = CarrierLocation.new
        location.name = params[:carrier_contact][:location_id]
        location.address = params[:carrier_contact][:address]
        location.country = params[:carrier_contact][:country]
        location.state = params[:carrier_contact][:state]
        location.city = params[:carrier_contact][:city]
        location.postal = params[:carrier_contact][:postal]
        location.carrier_id = params[:carrier_contact][:carrier_id]
        location.save
        @location_id = location.id
      end
    end
    params[:carrier_contact][:location_id]=  @location_id
    respond_to do |format|
      if @carrier_contact.update(carrier_contact_params)
        if params[:carrier_contact][:email].present? || (params[:carrier_contact][:password].present? && params[:carrier_contact][:password_confirmation].present?)
          if @carrier_contact.user.nil?
            @user = User.new(user_params)
            @user.carrier_contact_id = @carrier_contact.id
            @user.skip_confirmation!
            if @user.save
              @user.add_role :contact
            end
          else
            @carrier_contact.user.update(user_params)
          end
        end
        carrier = Carrier.find(@carrier_contact.carrier_id)
        if params[:pdm].present?
          carrier.update_attributes(:pdm_id => @carrier_contact.id)
        end
        if params[:poc].present?
          carrier.update_attributes(:poc_id => @carrier_contact.id)
        end
        if params[:same_ho].present?
          @carrier_contact.update_attributes(:same_ho => true)
        else
          @carrier_contact.update_attributes(:same_ho => false)
        end
        format.html { redirect_to carrier_path(:id => carrier.id), notice: 'Carrier contact was successfully updated.' }
        format.json { render :show, status: :ok, location: @carrier_contact }
      else
        format.html { render :edit }
        format.json { render json: @carrier_contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /carrier_contacts/1
  # DELETE /carrier_contacts/1.json
  def destroy
    @carrier_contact.destroy
    respond_to do |format|
      format.html { redirect_to carrier_path(:id => @carrier_contact.carrier_id), notice: 'Carrier contact was successfully removed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_carrier_contact
      @carrier_contact = CarrierContact.find(params[:id])
      authorize @carrier_contact
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def carrier_contact_params
      params[:carrier_contact][:adm] = params[:adm].present?
      params.require(:carrier_contact).permit(:title, :first_name, :last_name, :email, :work_phone, :home_phone, :location_id, :carrier_id, :linkedin_link, :adm)
    end
    def user_params
      params.require(:carrier_contact).permit(:first_name, :last_name, :email, :password)
    end
end
