class MailsController < ApplicationController
  layout 'mail'
  def new
    @contacts = []
  end

  def create
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def mail_params
      params.require(:mail).permit()
    end
end
