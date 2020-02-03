class ShipperDecorator < ApplicationDecorator
  include Draper::LazyHelpers
  delegate :company_name

  def link_to
    h.render :partial => "shippers/link", :locals => {shipper: object}, :formats => [:html, :json]
  end

  def lanes
    h.render :partial => "shippers/lane", :locals => {shipper: object}, :formats => [:html, :json]
  end

  def commodities
    h.render :partial => "shippers/commodities", :locals => {shipper: object}, :formats => [:html, :json]
  end

  def mc_number
    h.render :partial => "shippers/mc_number", :locals => {shipper: object}, :formats => [:html, :json]
  end

end
