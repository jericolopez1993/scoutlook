class CarrierDecorator < ApplicationDecorator
  include Draper::LazyHelpers
  delegate :company_name

  def link_to
    h.render :partial => "carriers/link", :locals => {carrier: object}, :formats => [:html, :json]
  end

  def truncate_link_to
    h.render :partial => "carriers/truncate_link", :locals => {carrier: object}, :formats => [:html, :json]
  end

  def lanes
    h.render :partial => "carriers/lane", :locals => {carrier: object}, :formats => [:html, :json]
  end

  def mc_number
    h.render :partial => "carriers/mc_number", :locals => {carrier: object}, :formats => [:html, :json]
  end

end
