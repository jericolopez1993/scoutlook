class CarrPromDecorator < ApplicationDecorator
  include Draper::LazyHelpers
  delegate :carrier_name

  def link_to
    h.render :partial => "carriers/link", :locals => {carrier: object.assigned_carrier}, :formats => [:html, :json]
  end

end
