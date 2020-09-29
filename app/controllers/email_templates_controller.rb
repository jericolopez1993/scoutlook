class EmailTemplatesController < ApplicationController
  before_action :set_email_template, only: [:index, :show, :edit, :update, :destroy]

  def index
    render :show
  end

  # GET /load/1
  # GET /load/1.json
  def show
  end

  # GET /load/1
  # GET /load/1.json
  def edit
  end

  def update
    respond_to do |format|
      if @email_template.update(email_template_params)
        if params[:email_template][:logo_image].present?
          @email_template.logo_image.attach(params[:email_template][:logo_image])
        end
        format.html { redirect_to email_templates_path, notice: 'Email Template was successfully updated.' }
        format.json { render :show, status: :ok, location: @email_template }
      else
        format.html { render :edit }
        format.json { render json: @email_template.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_email_template
      @email_template = EmailTemplate.first
    end

    def email_template_params
      params.require(:email_template).permit(:name, :footer_description)
    end

end
