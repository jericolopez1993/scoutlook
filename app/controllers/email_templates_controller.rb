class EmailTemplatesController < ApplicationController
  before_action :set_email_template, only: [:show, :edit, :update, :destroy]

  # GET /load/1
  # GET /load/1.json
  def show
  end

  # GET /load/1
  # GET /load/1.json
  def edit
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_email_template
      @email_template = EmailTemplate.first
    end

end
