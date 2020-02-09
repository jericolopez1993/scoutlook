class ActivityDecorator < ApplicationDecorator
  include Draper::LazyHelpers
  delegate :company_name

  def link_to_shipper
    h.render :partial => "shippers/link", :locals => {shipper: object.shipper}, :formats => [:html, :json]
  end

  def link_to_carrier
    h.render :partial => "carriers/link", :locals => {carrier: object.carrier}, :formats => [:html, :json]
  end

  def notes
    h.render :partial => "activities/note", :locals => {activity: object}, :formats => [:html, :json]
  end

  def dt_actions
    links = []
    links << (h.link_to '<i class="far fa-eye"></i>'.html_safe, activity_path(:id => object.id), :class => 'btn btn-info btn-xs', target: :_blank)
    links << (h.link_to '<i class="far fa-edit"></i>'.html_safe, edit_activity_path(:id => object.id), :class => 'btn btn-warning btn-xs', target: :_blank)
    links << (h.link_to '<i class="far fa-file-pdf"></i>'.html_safe, generate_pdf_activities_path(:id => object.id), target: :_blank, :class => 'btn btn-indigo btn-xs')
    links << (h.link_to '<i class="far fa-paper-plane"></i>'.html_safe, new_mail_path(:id => object.id), :class => 'btn btn-dark btn-xs')
    links << (h.link_to '<i class="fas fa-trash-alt"></i>'.html_safe, activity_path(:id => object.id), method: :delete, data: { confirm: 'Are you sure?' }, :class => 'btn btn-danger btn-xs')
    h.safe_join(links, '')
  end

end
