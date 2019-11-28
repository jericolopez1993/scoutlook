class CarrierDecorator < ApplicationDecorator
  include Draper::LazyHelpers
  delegate :company_name

  def link_to
    h.render :partial => "carriers/link", :locals => {carrier: object}, :formats => [:html, :json]
  end

  def lanes
    h.render :partial => "carriers/lane", :locals => {carrier: object}, :formats => [:html, :json]
  end

end
