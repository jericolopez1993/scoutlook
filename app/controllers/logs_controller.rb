class LogsController < ApplicationController
  def index
    @logs = Audit.overall
  end
end
