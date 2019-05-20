class ShipperCompaniesController < ApplicationController
  before_action :set_shipper_company, only: [:show, :edit, :update, :destroy]

  # GET /shipper_companies
  # GET /shipper_companies.json
  def index
    @shipper_companies = ShipperCompany.all
  end

  # GET /shipper_companies/1
  # GET /shipper_companies/1.json
  def show
  end

  # GET /shipper_companies/new
  def new
    @shipper_company = ShipperCompany.new
    if params[:shipper_id].present?
      @shipper_company.shipper_id = params[:shipper_id]
    end
  end

  # GET /shipper_companies/1/edit
  def edit
  end

  # POST /shipper_companies
  # POST /shipper_companies.json
  def create
    @shipper_company = ShipperCompany.new(shipper_company_params)

    respond_to do |format|
      if @shipper_company.save
        format.html { redirect_to @shipper_company, notice: 'Shipper company was successfully created.' }
        format.json { render :show, status: :created, location: @shipper_company }
      else
        format.html { render :new }
        format.json { render json: @shipper_company.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /shipper_companies/1
  # PATCH/PUT /shipper_companies/1.json
  def update
    respond_to do |format|
      if @shipper_company.update(shipper_company_params)
        format.html { redirect_to @shipper_company, notice: 'Shipper company was successfully updated.' }
        format.json { render :show, status: :ok, location: @shipper_company }
      else
        format.html { render :edit }
        format.json { render json: @shipper_company.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shipper_companies/1
  # DELETE /shipper_companies/1.json
  def destroy
    @shipper_company.destroy
    respond_to do |format|
      format.html { redirect_to shipper_path(:id => @shipper_company.shipper_id), notice: 'Shipper company was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shipper_company
      @shipper_company = ShipperCompany.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def shipper_company_params
      params.require(:shipper_company).permit(:name, :city, :state, :company_type, :phone_number, :website, :shipper_id)
    end
end
