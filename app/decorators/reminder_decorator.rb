class ReminderDecorator < ApplicationDecorator
  include Draper::LazyHelpers
  delegate :id

  def link_to_shipper
    h.render :partial => "shippers/link", :locals => {shipper: object.shipper}, :formats => [:html, :json]
  end

  def link_to_carrier
    h.render :partial => "carriers/link", :locals => {carrier: object.carrier}, :formats => [:html, :json]
  end

  def notes
    h.render :partial => "reminders/note", :locals => {reminder: object}, :formats => [:html, :json]
  end

  def next_reminder_date
    h.render :partial => "reminders/next_reminder_date", :locals => {reminder: object}, :formats => [:html, :json]
  end

  def dt_actions
    links = []
    links << (h.link_to '<i class="far fa-eye"></i>'.html_safe, reminder_path(:id => object.id, :previous_controller => params[:controller]), :class => 'btn btn-info btn-xs', target: :_blank)
    links << (h.link_to '<i class="far fa-edit"></i>'.html_safe, edit_reminder_path(object.id), :class => 'btn btn-warning btn-xs')
    links << (h.link_to '<i class="fas fa-trash-alt"></i>'.html_safe, reminder_path(:id => object.id, :previous_controller => params[:controller]), method: :delete, data: { confirm: 'Are you sure?' }, :class => 'btn btn-danger btn-xs')

    h.safe_join(links, '')
  end

end
