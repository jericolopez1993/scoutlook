class ClientsController < ApplicationController
  include ApplicationHelper
  before_action :set_client, only: [:show, :edit, :update, :destroy, :remove_attachment]

  # GET /clients
  # GET /clients.json
  def index
    @clients = Client.all
    authorize @clients
  end

  # GET /clients/1
  # GET /clients/1.json
  def show
  end

  # GET /clients/new
  def new
    @client = Client.new
    authorize @client
  end

  # GET /clients/1/edit
  def edit
  end

  # POST /clients
  # POST /clients.json
  def create
    @client = Client.new(client_params)
    respond_to do |format|
      if @client.save
        @location = Location.new(location_params)
        @location.client_id = @client.id
        if @location.save
          @client.update_attributes(:head_office => @location.id)
        end
        if params[:client][:attachment_file].present?
          @client.attachment_file.attach(params[:client][:attachment_file])
        end

        format.html { redirect_to @client, notice: 'Client was successfully created.' }
        format.json { render :show, status: :created, location: @client }
      else
        format.html { render :new }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /clients/1
  # PATCH/PUT /clients/1.json
  def update
    respond_to do |format|
      if @client.update(client_params)
        if params[:origin].present? || params[:destination].present? || params[:client][:location_name].present? || params[:client][:state].present? || params[:client][:city].present?
          @client.location.update_attributes(location_params)
        end
        if params[:client][:attachment_file].present?
          @client.attachment_file.attach(params[:client][:attachment_file])
        end
        format.html { redirect_to @client, notice: 'Client was successfully updated.' }
        format.json { render :show, status: :ok, location: @client }
      else
        format.html { render :edit }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clients/1
  # DELETE /clients/1.json
  def destroy
    @client.destroy
    respond_to do |format|
      format.html { redirect_to clients_url, notice: 'Client was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def origins
    if  params[:client_id].present?
      client = Client.find(params[:client_id])
      render json: {:client_id => client.id, :origins => client.origin}
    else
      render json: {:client_id => nil, :origins => nil}
    end

  end

  def remove_attachment
    respond_to do |format|
      if @client.attachment_file.find(params[:attachment_id]).purge
        format.html { redirect_to client_path(:id => @client.id), notice: 'Attachment Successfully Removed.' }
        format.json { render :show, status: :ok, location: @client }
      else
        format.html { redirect_to client_path(:id => @client.id), error: 'Attachment Remove Failed.' }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client
      @client = Client.find(params[:id])
      authorize @client
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def client_params
      params.require(:client).permit(:client_type, :relationship_owner, :company_name, :client_id, :parent_id, :sales_priority, :phone, :annual_revenue, :industry, :primary_industry, :hazardous, :food_grade, :freight_revenue, :volume_intra, :volume_inter, :volume_to_usa, :volume_from_usa, :notes, :credit_status, :credit_approval)
    end

    def location_params
      params[:client][:is_origin] = params[:origin].present?
      params[:client][:is_destination] = params[:destination].present?
      params[:client][:name] = params[:client][:location_name]
      params.require(:client).permit(:name, :address, :country, :state, :city, :postal, :is_origin, :is_destination, :loc_type, :phone)
    end
end
