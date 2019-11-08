class DfLoadDecorator < ApplicationDecorator
  include Draper::LazyHelpers
  delegate :carrier

  def link_to
    h.render :partial => "carriers/link", :locals => {carrier: object.assigned_carrier}, :formats => [:html, :json]
  end

end
