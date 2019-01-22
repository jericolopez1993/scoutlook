class ShipperContactsController < ApplicationController
  before_action :set_shipper_contact, only: [:show, :edit, :update, :destroy]

  # GET /shipper_contacts
  # GET /shipper_contacts.json
  def index
    @shipper_contacts = ShipperContact.all
    authorize @shipper_contacts
  end

  # GET /shipper_contacts/1
  # GET /shipper_contacts/1.json
  def show
  end

  # GET /shipper_contacts/new
  def new
    @shipper_contact = ShipperContact.new
    if params[:shipper_id].present?
      @shipper_contact.shipper_id = params[:shipper_id]
    end
    authorize @shipper_contact
  end

  # GET /shipper_contacts/1/edit
  def edit
    shipper = Shipper.find(@shipper_contact.shipper_id)
    @is_pdm = shipper.pdm_id == @shipper_contact.id
    @is_poc = shipper.poc_id == @shipper_contact.id
  end

  # POST /shipper_contacts
  # POST /shipper_contacts.json
  def create
    @shipper_contact = ShipperContact.new(shipper_contact_params)
    params.require(:shipper_contact).permit(:first_name, :last_name, :email, :password, :password_confirmation)
    @location_id = nil
    if params[:shipper_contact][:location_id].present? || params[:shipper_contact][:address].present? || params[:shipper_contact][:country].present? ||  params[:shipper_contact][:state].present? ||  params[:shipper_contact][:postal].present? ||  params[:shipper_contact][:city].present?
      if is_numeric?(params[:shipper_contact][:location_id])
          @location_id = params[:shipper_contact][:location_id]
      else
        location = ShipperLocation.new
        location.name = params[:shipper_contact][:location_id]
        location.address = params[:shipper_contact][:address]
        location.country = params[:shipper_contact][:country]
        location.state = params[:shipper_contact][:state]
        location.city = params[:shipper_contact][:city]
        location.postal = params[:shipper_contact][:postal]
        location.shipper_id = params[:shipper_contact][:shipper_id]
        location.save
        @location_id = location.id
      end
    end
    @shipper_contact.location_id =  @location_id
    respond_to do |format|
      if @shipper_contact.save
        if params[:shipper_contact][:email].present? && params[:shipper_contact][:password].present? && params[:shipper_contact][:password_confirmation].present?
          @user = User.new(user_params)
          @user.shipper_contact_id = @shipper_contact.id
          @user.skip_confirmation!
          if @user.save
            @user.add_role :contact
          end
        end
        shipper = Shipper.find(@shipper_contact.shipper_id)

        if params[:pdm].present?
          shipper.update_attributes(:pdm_id => @shipper_contact.id)
        else
          shipper.update_attributes(:pdm_id => nil)
        end
        if params[:poc].present?
          shipper.update_attributes(:poc_id => @shipper_contact.id)
        else
          shipper.update_attributes(:poc_id => nil)
        end
        format.html { redirect_to shipper_path(:id => shipper.id), notice: 'Shipper contact was successfully created.' }
        format.json { render :show, status: :created, location: @shipper_contact }
      else
        format.html { render :new }
        format.json { render json: @shipper_contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /shipper_contacts/1
  # PATCH/PUT /shipper_contacts/1.json
  def update
    @location_id = nil
    if params[:shipper_contact][:location_id].present? || params[:shipper_contact][:address].present? || params[:shipper_contact][:country].present? ||  params[:shipper_contact][:state].present? ||  params[:shipper_contact][:postal].present? ||  params[:shipper_contact][:city].present?
      if is_numeric?(params[:shipper_contact][:location_id])
          @location_id = params[:shipper_contact][:location_id]
      else
        location = ShipperLocation.new
        location.name = params[:shipper_contact][:location_id]
        location.address = params[:shipper_contact][:address]
        location.country = params[:shipper_contact][:country]
        location.state = params[:shipper_contact][:state]
        location.city = params[:shipper_contact][:city]
        location.postal = params[:shipper_contact][:postal]
        location.shipper_id = params[:shipper_contact][:shipper_id]
        location.save
        @location_id = location.id
      end
    end
    params[:shipper_contact][:location_id]=  @location_id
    respond_to do |format|
      if @shipper_contact.update(shipper_contact_params)
        if params[:shipper_contact][:email].present? || (params[:shipper_contact][:password].present? && params[:shipper_contact][:password_confirmation].present?)
          if @shipper_contact.user.nil?
            @user = User.new(user_params)
            @user.shipper_contact_id = @shipper_contact.id
            @user.skip_confirmation!
            if @user.save
              @user.add_role :contact
            end
          else
            @shipper_contact.user.update(user_params)
          end
        end
        shipper = Shipper.find(@shipper_contact.shipper_id)
        if params[:pdm].present?
          shipper.update_attributes(:pdm_id => @shipper_contact.id)
        else
          shipper.update_attributes(:pdm_id => nil)
        end
        if params[:poc].present?
          shipper.update_attributes(:poc_id => @shipper_contact.id)
        else
          shipper.update_attributes(:poc_id => nil)
        end

        format.html { redirect_to shipper_path(:id => shipper.id), notice: 'Shipper contact was successfully updated.' }
        format.json { render :show, status: :ok, location: @shipper_contact }
      else
        format.html { render :edit }
        format.json { render json: @shipper_contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shipper_contacts/1
  # DELETE /shipper_contacts/1.json
  def destroy
    @shipper_contact.destroy
    respond_to do |format|
      format.html { redirect_to shipper_path(:id => @shipper_contact.shipper_id), notice: 'Shipper contact was successfully removed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shipper_contact
      @shipper_contact = ShipperContact.find(params[:id])
      authorize @shipper_contact
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def shipper_contact_params
      params.require(:shipper_contact).permit(:title, :first_name, :last_name, :email, :location_id, :shipper_id, :linkedin_link, :adm, :same_ho, :contact_type, :primary_phone, :primary_phone_type, :secondary_phone, :secondary_phone_type, :address, :city, :postal, :country, :state, :primary_extension_number, :secondary_extension_number, :notes)
    end
    def user_params
      params.require(:shipper_contact).permit(:first_name, :last_name, :email, :password)
    end
end
