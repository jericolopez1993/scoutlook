class LogsController < ApplicationController
  def index
    respond_to do |format|
      format.html
      format.json { render json: LogDatatable.new(params, user: current_user, view_context: view_context) }
    end
  end
end
