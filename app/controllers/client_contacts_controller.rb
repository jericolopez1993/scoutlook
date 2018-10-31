class ClientContactsController < ApplicationController
  include ApplicationHelper
  before_action :set_client_contact, only: [:show, :edit, :update, :destroy]

  # GET /client_contacts
  # GET /client_contacts.json
  def index
    @client_contacts = ClientContact.all
    authorize @client_contacts
  end

  # GET /client_contacts/1
  # GET /client_contacts/1.json
  def show
  end

  # GET /client_contacts/new
  def new
    @client_contact = ClientContact.new
    if params[:client_id].present?
      @client_contact.client_id = params[:client_id]
    end
    authorize @client_contact
  end

  # GET /client_contacts/1/edit
  def edit
    client = Client.find(@client_contact.client_id)
    @is_pdm = client.pdm_id == @client_contact.id
    @is_poc = client.poc_id == @client_contact.id
  end

  # POST /client_contacts
  # POST /client_contacts.json
  def create
    @client_contact = ClientContact.new(client_contact_params)
    @user = User.new(user_params)
    @user.skip_confirmation!
    if params[:same_ho].present?
      @client_contact.same_ho = true
    else
      @client_contact.same_ho = false
    end
    @location_id = nil
    if params[:client_contact][:location_id].present? || params[:client_contact][:address].present? || params[:client_contact][:country].present? ||  params[:client_contact][:state].present? ||  params[:client_contact][:postal].present? ||  params[:client_contact][:city].present?
      if is_numeric?(params[:client_contact][:location_id])
          @location_id = params[:client_contact][:location_id]
      else
        location = Location.new
        location.name = params[:client_contact][:location_id]
        location.address = params[:client_contact][:address]
        location.country = params[:client_contact][:country]
        location.state = params[:client_contact][:state]
        location.city = params[:client_contact][:city]
        location.postal = params[:client_contact][:postal]
        location.client_id = MasterInvoice.find(params[:client_contact][:header]).shipper_id
        location.save
        @location_id = location.id
      end
    end
    @client_contact.location_id =  @location_id
    respond_to do |format|
      if @client_contact.save && @user.save
        @user.update_attributes(:client_contact_id => @client_contact.id)
        @user.add_role :contact
        client = Client.find(@client_contact.client_id)

        if params[:pdm].present?
          client.update_attributes(:pdm_id => @client_contact.id)
        end
        if params[:poc].present?
          client.update_attributes(:poc_id => @client_contact.id)
        end
        format.html { redirect_to client_path(:id => client.id), notice: 'Client contact was successfully created.' }
        format.json { render :show, status: :created, location: @client_contact }
      else
        format.html { render :new }
        format.json { render json: @client_contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /client_contacts/1
  # PATCH/PUT /client_contacts/1.json
  def update
    @location_id = nil
    if params[:client_contact][:location_id].present? || params[:client_contact][:address].present? || params[:client_contact][:country].present? ||  params[:client_contact][:state].present? ||  params[:client_contact][:postal].present? ||  params[:client_contact][:city].present?
      if is_numeric?(params[:client_contact][:location_id])
          @location_id = params[:client_contact][:location_id]
      else
        location = Location.new
        location.name = params[:client_contact][:location_id]
        location.address = params[:client_contact][:address]
        location.country = params[:client_contact][:country]
        location.state = params[:client_contact][:state]
        location.city = params[:client_contact][:city]
        location.postal = params[:client_contact][:postal]
        location.client_id = MasterInvoice.find(params[:client_contact][:header]).shipper_id
        location.save
        @location_id = location.id
      end
    end
    params[:client_contact][:location_id]=  @location_id
    respond_to do |format|
      if @client_contact.update(client_contact_params)
        client = Client.find(@client_contact.client_id)
        if params[:pdm].present?
          client.update_attributes(:pdm_id => @client_contact.id)
        end
        if params[:poc].present?
          client.update_attributes(:poc_id => @client_contact.id)
        end
        if params[:same_ho].present?
          @client_contact.update_attributes(:same_ho => true)
        else
          @client_contact.update_attributes(:same_ho => false)
        end
        format.html { redirect_to client_path(:id => client.id), notice: 'Client contact was successfully updated.' }
        format.json { render :show, status: :ok, location: @client_contact }
      else
        format.html { render :edit }
        format.json { render json: @client_contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /client_contacts/1
  # DELETE /client_contacts/1.json
  def destroy
    @client_contact.destroy
    respond_to do |format|
      format.html { redirect_to client_path(:id => @client_contact.client_id), notice: 'Client contact was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client_contact
      @client_contact = ClientContact.find(params[:id])
      authorize @client_contact
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def client_contact_params
      params.require(:client_contact).permit(:title, :first_name, :last_name, :email, :work_phone, :home_phone, :location_id, :client_id, :linkedin_link)
    end
    def user_params
      params.require(:client_contact).permit(:first_name, :last_name, :email, :password, :password_confirmation)
    end
end
