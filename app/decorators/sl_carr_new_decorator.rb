class SlCarrNewDecorator < ApplicationDecorator
  include Draper::LazyHelpers
  delegate :carrier_name

  def link_to
    h.render :partial => "carriers/link", :locals => {carrier: object.assigned_carrier}, :formats => [:html, :json]
  end

  def truncate_link_to
    h.render :partial => "carriers/truncate_link", :locals => {carrier: object.assigned_carrier}, :formats => [:html, :json]
  end

  def truncate_carrier_name
    h.render :partial => "carriers/name", :locals => {name: object.carrier_name}, :formats => [:html, :json]
  end

end
