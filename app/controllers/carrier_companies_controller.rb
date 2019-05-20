class CarrierCompaniesController < ApplicationController
  before_action :set_carrier_company, only: [:show, :edit, :update, :destroy]

  # GET /carrier_companies
  # GET /carrier_companies.json
  def index
    @carrier_companies = CarrierCompany.all
  end

  # GET /carrier_companies/1
  # GET /carrier_companies/1.json
  def show
  end

  # GET /carrier_companies/new
  def new
    @carrier_company = CarrierCompany.new
    if params[:carrier_id].present?
      @carrier_company.carrier_id = params[:carrier_id]
    end
  end

  # GET /carrier_companies/1/edit
  def edit
  end

  # POST /carrier_companies
  # POST /carrier_companies.json
  def create
    @carrier_company = CarrierCompany.new(carrier_company_params)

    respond_to do |format|
      if @carrier_company.save
        format.html { redirect_to @carrier_company, notice: 'Carrier company was successfully created.' }
        format.json { render :show, status: :created, location: @carrier_company }
      else
        format.html { render :new }
        format.json { render json: @carrier_company.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /carrier_companies/1
  # PATCH/PUT /carrier_companies/1.json
  def update
    respond_to do |format|
      if @carrier_company.update(carrier_company_params)
        format.html { redirect_to @carrier_company, notice: 'Carrier company was successfully updated.' }
        format.json { render :show, status: :ok, location: @carrier_company }
      else
        format.html { render :edit }
        format.json { render json: @carrier_company.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /carrier_companies/1
  # DELETE /carrier_companies/1.json
  def destroy
    @carrier_company.destroy
    respond_to do |format|
      format.html { redirect_to carrier_path(:id => @carrier_company.carrier_id), notice: 'Carrier company was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_carrier_company
      @carrier_company = CarrierCompany.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def carrier_company_params
      params.require(:carrier_company).permit(:name, :city, :state, :company_type, :phone_number, :website, :carrier_id)
    end
end
