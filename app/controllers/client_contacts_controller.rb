class ClientContactsController < ApplicationController
  before_action :set_client_contact, only: [:show, :edit, :update, :destroy]

  # GET /client_contacts
  # GET /client_contacts.json
  def index
    @client_contacts = ClientContact.all
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
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def client_contact_params
      params.require(:client_contact).permit(:title, :first_name, :last_name, :email, :work_phone, :home_phone, :address, :city, :state, :postal, :country, :client_id)
    end
    def user_params
      params.require(:client_contact).permit(:first_name, :last_name, :email, :password, :password_confirmation)
    end
end
