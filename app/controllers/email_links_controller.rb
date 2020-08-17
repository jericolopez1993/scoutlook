class EmailLinksController < ApplicationController
  before_action :set_email_link, only: [:show, :edit, :update, :destroy]

  # GET /load/1
  # GET /load/1.json
  def show
  end

  def new
    @email_link = EmailLink.new
  end

  def create
    @email_link = EmailLink.new(email_link_params)
    respond_to do |format|
      if @email_link.save
        if params[:email_link][:logo_image].present?
          @email_link.logo_image.attach(params[:email_link][:logo_image])
        end
        format.html { redirect_to email_templates_path, notice: 'Image Link was successfully created.' }
        format.json { render :show, status: :created, location: @email_link }
      else
        format.html { render :new }
        format.json { render json: @email_link.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /load/1
  # GET /load/1.json
  def edit
  end

  def update
    respond_to do |format|
      if @email_link.update(email_link_params)
        if params[:email_link][:logo_image].present?
          @email_link.logo_image.attach(params[:email_link][:logo_image])
        end
        format.html { redirect_to email_templates_path, notice: 'Image Link was successfully updated.' }
        format.json { render :show, status: :ok, location: @email_link }
      else
        format.html { render :edit }
        format.json { render json: @email_link.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @email_link.destroy
    respond_to do |format|
      format.html { redirect_to email_templates_path, notice: 'Image Link was successfully removed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_email_link
      @email_link = EmailLink.find(params[:id])
    end

    def email_link_params
      params.require(:email_link).permit(:position, :link)
    end

end
