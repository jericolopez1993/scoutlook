module ApplicationHelper
  include HTTParty

  def generate_alphanumeric_id(str = "", id)
    count = id.to_s.rjust(3, '0')
    if str.nil?
      str = ""
    end
    alp = str.gsub(/[^0-9A-Za-z]/, '')[0, 3].upcase
    alp + count
  end

  def generate_two_alphanumeric_id(str1 = "", str2 = "", id)
    count = id.to_s.rjust(3, '0')
    if str1.nil?
      str1 = ""
    end
    if str2.nil?
      str2 = ""
    end
    alp1 = str1.gsub(/[^0-9A-Za-z]/, '')[0, 3].upcase
    alp2 = str2.gsub(/[^0-9A-Za-z]/, '')[0, 3].upcase
    alp1 + alp2  + count
  end

  def convert_date(val)
    unless val.nil?
      val.strftime("%m/%d/%Y")
    end
  end

  def location_format(location)
    if location.country.upcase == "USA" || location.country.upcase == "CANADA"
      "<b>#{location.name}</b><br/>#{location.city}, #{location.state}".html_safe
    else
      "<b>#{location.name}</b><br/>#{location.city} #{location.state}, #{location.country}".html_safe
    end
  end

  def location_format_for_us_and_canada(location)
    "<b>#{location.name}</b><br/>#{location.address} #{location.city} #{location.state}, #{location.country} #{location.postal}".html_safe
  end

  def is_numeric?(obj)
   obj.to_s.match(/\A[+-]?\d+?(\.\d+)?\Z/) == nil ? false : true
  end

  def get_distance(origin, destination)
      begin
        str_url = "https://maps.googleapis.com/maps/api/distancematrix/json?&origins=" + origin + "&destinations=" + destination + "&key=AIzaSyCbFFNkesD-8_F4lMdyihwqpARlDYmG6k0"
        response = HTTParty.get(str_url)
        body = JSON.parse(response.body)
        temp_distance =  body['rows'][0]['elements'][0]['distance']['value'].nil? ? 0 :  body['rows'][0]['elements'][0]['distance']['value']
        distance = temp_distance / 1000
      rescue
        puts 'Google Maps API error'
        distance
      end
  end

  def get_map(origin, destination)
    require 'uri'
    URI.parse("https://maps.googleapis.com/maps/api/staticmap?size=512x512&maptype=roadmap\&markers=size:mid%7Ccolor:red%7C#{origin}%7C#{destination}&key=AIzaSyCbFFNkesD-8_F4lMdyihwqpARlDYmG6k0")
  end

  def get_currency(country)
    currency = ''
    if !country.nil? && country != ''
      if country == 'CDN'
        currency = 'Can$'
      elsif country == 'US'
        currency = 'US$'
      end
    end
    currency
  end

  def get_shipper_locations(id)
    if id != "" && !id.nil?
      begin
        master_invoice = MasterInvoice.find(id)
        client_location_ids = ClientLocation.where(:client_id => master_invoice.shipper_id).distinct(:location_id).pluck(:location_id).map(&:inspect).join(',')
        if client_location_ids != ''
           Location.where("id IN (#{client_location_ids})")
         else
           []
        end
      rescue
        []
      end
    else
      []
    end
  end

  def get_quotient(num1, num2)
    if num1.nil?
      num1 = 0
    end

    if num2.nil?
      num2 = 0
    end

    if num1 != 0 && num2 != 0
      num1 / num2
    else
      0
    end
  end

  def get_user_full_name(id)
    begin
      user = User.find(id)
      user.first_name + " " + user.last_name
    rescue
      ""
    end
  end

  def is_enumerable?(object)
    object.is_a? Enumerable
  end

  def get_value(object)
    if object.present?
      if is_enumerable?(object)
        object[1]
      else
        object
      end
    else
      ''
    end
  end

  def get_value_with_html(object)
    get_value(object).html_safe
  end

  def get_geo(origin, destination)
    if !origin.nil? || !destination.nil?
      geo = "Domestic"
      if !origin.nil?
        if origin.country != "Canada"
          geo = "International"
        end
      end
      if !destination.nil?
        if destination.country != "Canada"
          geo = "International"
        end
      end
      "<span class='badge badge-#{get_color_badge(geo)}'>#{geo}</span>".html_safe
    else
      ""
    end
  end

  def get_color_badge(str)
    if str == "Approved" || str == "Drop-ship"
      "warning"
    elsif str == "Review" || str == "Supplier Return"
      "green"
    elsif str == "Dispute" || str == "Outbound"
      "danger"
    elsif str == "Corrected" || str == "Stock"
      "yellow"
    elsif str == "ReBill" || str == "Transfer"
      "info"
    elsif str == "Inbound"
      "success"
    elsif str == "Customer Return"
      "lime"
    elsif str == "Domestic" || str == "Single"
      "secondary"
    elsif str == "International" || str == "Multiple"
      "dark"
    end
  end

  def format_address(address=nil, city=nil, state=nil, country=nil, postal=nil)
    str = ""
    if !address.nil? && address != ""
      str += address.titleize + ", "
    end
    if !city.nil? && city != ""
      str += city.titleize + ", "
    end
    if !state.nil? && state != ""
      str += state.upcase + ", "
    end
    if !country.nil? && country != ""
      str += country.upcase + " "
    end
    if !postal.nil? && postal != ""
      str += postal.titleize
    end
    str
  end

  def convert_array(arr)
    begin
      arr.to_s.tr('[]', '').tr('"', '')[2..-1].gsub(', ', ',').to_s
    rescue
      ""
    end
  end

  def convert_decimal(num)
    begin
      num.gsub('$ ', '').gsub(',', '').to_d
    rescue
      0
    end
  end

  def shade_sales_priority(sales_priority)
    if sales_priority.include?("A")
      "<span class='text-lime'>#{sales_priority}</span>"
    elsif sales_priority.include?("B")
      "<span class='text-indigo'>#{sales_priority}</span>"
    elsif sales_priority.include?("D")
      "<span class='text-pink'>#{sales_priority}</span>"
    elsif sales_priority.include?("C")
      "<span class='text-purple'>#{sales_priority}</span>"
    elsif sales_priority.include?("U")
      "<span class='text-success'>#{sales_priority}</span>"
    elsif sales_priority.include?("New")
      "<span class='text-yellow'>#{sales_priority}</span>"
    else
      "<span class='text-dark'>#{sales_priority}</span>"
    end
  end
  def interval_to_text(reminder_interval)
    if reminder_interval == 7
      "1 wk"
    elsif reminder_interval == 14
      "2 wk"
    elsif reminder_interval == 30
      "1M"
    elsif reminder_interval == 90
      "3M"
    elsif reminder_interval == 180
      "6M"
    elsif reminder_interval == 360
      "12M"
    else
      ""
    end
  end

  def reminder_to_sentence(reminder)
    on_sentence = ""

    if reminder.carrier
      on_sentence = on_sentence + reminder.carrier.display_name
    elsif reminder.shipper
      on_sentence = on_sentence + reminder.shipper.display_name
    elsif reminder.activity
      on_sentence = on_sentence + reminder.activity.display_name
    else
      on_sentence = on_sentence + reminder.display_name
    end
    if reminder.carrier || reminder.shipper || reminder.activity
      on_sentence = on_sentence + " has a <a data-toggle='tooltip' data-placement='right' data-html='true' title='Types: #{reminder.reminder_type.nil? ? '' : reminder.reminder_type} <br>Notes: #{reminder.notes.nil? ? '' : reminder.notes}' href='/reminders/#{reminder.id}'>Reminder</a>#{truncate_html(reminder.notes, :length => 50, :omission => '...', :escape => false)}"
    else
      on_sentence = "There is a " + on_sentence + "."
    end
    on_sentence
  end

  def date_to_words(date)
    date.strftime("%B %d - %^a")
  end

  def reminder_to_html(reminder)
    str_date = ""
    if reminder.recurring
      if reminder.last_reminded
        str_date = generate_reminder(reminder.last_reminded, reminder.reminder_interval, reminder.reminder_date, reminder.reminder_type, reminder.notes)
      elsif reminder.reminder_date
        str_date = generate_reminder(reminder.reminder_date, reminder.reminder_interval, reminder.reminder_date, reminder.reminder_type,  reminder.notes)
      else
        current_date = reminder.created_at
        until current_date >= Date.today
          current_date += reminder.reminder_interval.days
        end
        if current_date >= Date.today
          str_date = str_date + "<span data-toggle='tooltip' data-placement='right' data-html='true' title='Types: #{reminder.reminder_type.nil? ? '' : reminder.reminder_type} <br>Notes: #{reminder.notes.nil? ? '' : reminder.notes}' class='badge badge-#{(current_date == Date.today) ? 'danger' : 'green'} badge-square'>#{current_date.strftime("%m/%d/%Y")}</span>"
        end
      end
    else
      if reminder.reminder_interval > 0
        if reminder.reminder_date
          quot = ((Date.today.to_date - reminder.reminder_date.to_date).to_i / reminder.reminder_interval)
          if quot >= 1 && reminder.reminder_date >= Date.today
            str_date = str_date + "<span data-toggle='tooltip' data-placement='right' data-html='true' title='Types: #{reminder.reminder_type.nil? ? '' : reminder.reminder_type} <br>Notes: #{reminder.notes.nil? ? '' : reminder.notes}'  class='badge badge-#{(quot == 1) ? 'danger' : 'green'} badge-square'>#{reminder.reminder_date.strftime("%m/%d/%Y")}</span>"
          else
            if (reminder.reminder_date + reminder.reminder_interval.days) == Date.today.to_date
              str_date = str_date + "<span data-toggle='tooltip' data-placement='right' data-html='true' title='Types: #{reminder.reminder_type.nil? ? '' : reminder.reminder_type} <br>Notes: #{reminder.notes.nil? ? '' : reminder.notes}'  class='badge badge-danger badge-square'>#{Date.today}</span>"
            end
          end
        else
          str_date = str_date + "<span data-toggle='tooltip' data-placement='right' data-html='true' title='Types: #{reminder.reminder_type.nil? ? '' : reminder.reminder_type} <br>Notes: #{reminder.notes.nil? ? '' : reminder.notes}' class='badge badge-green badge-square'>#{(reminder.created_at + reminder.reminder_interval.days).strftime("%m/%d/%Y")}</span>"
        end
      else
        if reminder.reminder_date
          if reminder.reminder_date >= Date.today
            str_date = str_date + "<span class='badge badge-#{(reminder.reminder_date == Date.today) ? 'danger' : 'green'} badge-square' data-toggle='tooltip' data-placement='right' data-html='true' title='Types: #{reminder.reminder_type.nil? ? '' : reminder.reminder_type} <br>Notes: #{reminder.notes.nil? ? '' : reminder.notes}' > #{reminder.reminder_date.strftime("%m/%d/%Y")}</span>"
          end
        end
      end
    end
    if !str_date.blank?
      str_date + "<br/>"
    else
      str_date
    end
  end

  def generate_reminder(current_date, interval, default_date, reminder_type, notes)
    str_date = ""
    if current_date <= Date.today
      if current_date == Date.today
        str_date = str_date + "<span data-toggle='tooltip' data-placement='right' data-html='true' title='Types: #{reminder_type.nil? ? '' : reminder_type} <br>Notes: #{notes.nil? ? '' : notes}' class='badge badge-danger badge-square'>#{current_date.strftime("%m/%d/%Y")}</span> "
      end
      until current_date >= Date.today
        current_date += interval.days
      end
      if interval > 0 && current_date > Date.today
        str_date = str_date + "<span data-toggle='tooltip' data-placement='right' data-html='true' title='Types: #{reminder_type.nil? ? '' : reminder_type} <br>Notes: #{notes.nil? ? '' : notes}' class='badge badge-green badge-square'>#{current_date.strftime("%m/%d/%Y")}</span>"
      end
    else
      str_date = str_date + "<span data-toggle='tooltip' data-placement='right' data-html='true' title='Types: #{reminder_type.nil? ? '' : reminder_type} <br>Notes: #{notes.nil? ? '' : notes}' class='badge badge-green badge-square'>#{default_date.strftime("%m/%d/%Y")}</span>"
    end
    str_date
  end

  def organize_date(date)
    if date.is_a? Date
      date = date.to_s
    end
    begin
      cdate = date.split("/")
      cdate[2] + "-" + cdate[0] + "-" + cdate[1]
    rescue
      date
    end
  end

  def generate_phone_type(phone_type, eligible_texting)
    str = ""
    if eligible_texting
      str = "TEXT"
    else
      if phone_type == "Land Line"
        str = "LAND"
      else
        str = phone_type
      end
    end
  end

  def generate_phone_number(extra_str, phone_number, extension_number, eligible_texting, phone_type)
    str = ""
    if !phone_number.nil? && phone_number != ""
      if extra_str != ""
        str = extra_str + ": "
      end
      str = str + phone_number
      if !extension_number.nil? && extension_number != ""
        str = str + ", Ext. " + extension_number
      end
      ptype = generate_phone_type(phone_type, eligible_texting)
      if !ptype.blank?
        str = str + " (" + generate_phone_type(phone_type, eligible_texting) + ")"
      end
      if extra_str == "P1"
        str = str + "<br/>"
      end
    end
    str
  end

  def generate_styling_activities(carrier, shipper)
    audits = get_audits(carrier, shipper)
    three_days_audits = audits.where(:created_at => (Date.today - 3.day)..Date.today)
    seven_days_audits = audits.where(:created_at => (Date.today - 7.day)..(Date.today - 3.day))

    if three_days_audits.present?
      "text-success"
    elsif seven_days_audits.present?
      "text-warning"
    else
      "text-danger"
    end
  end

  def get_audits(carrier=nil, shipper=nil)
    query = ""
    models = []
    values = []
    if carrier
      models = ['Carrier', 'CarrierCompany', 'CarrierContact', 'CarrierLane', 'CarrierLocation', 'Activity', 'Rate', 'Reminder']
      values << carrier.id.to_s
      values << carrier.carrier_companies.pluck(:id).join(",")
      values << carrier.carrier_contacts.pluck(:id).join(",")
      values << carrier.carrier_lanes.pluck(:id).join(",")
      values << carrier.locations.pluck(:id).join(",")
      values << carrier.activities.pluck(:id).join(",")
      values << carrier.rates.pluck(:id).join(",")
      values << carrier.reminders.pluck(:id).join(",")
    elsif shipper
      models = ['Shipper', 'ShipperCompany', 'ShipperContact', 'ShipperLane', 'ShipperLocation', 'Activity', 'Rate', 'Reminder']
      values << shipper.id.to_s
      values << shipper.shipper_companies.pluck(:id).join(",")
      values << shipper.shipper_contacts.pluck(:id).join(",")
      values << shipper.shipper_lanes.pluck(:id).join(",")
      values << shipper.locations.pluck(:id).join(",")
      values << shipper.activities.pluck(:id).join(",")
      values << shipper.rates.pluck(:id).join(",")
      values << shipper.reminders.pluck(:id).join(",")
    end

    if models.present? && values.present?
      x=0
      models.each do |model|
        if !values[x].blank?
          if !query.blank?
            query = query + " OR "
          end
          query = query + "(auditable_type = '#{model}' AND auditable_id IN (#{values[x]}))"
        end
        x=x+1
      end
    end

    if !query.blank?
      Audit.where(query).order("created_at DESC")
    else
      []
    end
  end

  def check_date(cdate)
    if cdate.is_a? String
      cdate = Date.parse(cdate)
    end
    cdate
  end

  def date_group_color(cdate)
     if cdate < Date.today
      "panel-darkred"
    elsif cdate == Date.today
      "panel-green"
    else
      "panel-inverse"
    end
  end

  def date_border_color(cdate)
     if cdate < Date.today
      "#500007;"
    elsif cdate == Date.today
      "#3d5700;"
    else
      "#242a30;"
    end
  end

  def truncate_html_to_sentence(notes)
    if !notes.nil?
      truncate(ActionView::Base.full_sanitizer.sanitize(notes), length: 50, omission: '...')
    else
      ""
    end
  end

  def generate_abv(loc)
    if loc == "NY-Brooklyn"
      "BKN"
    elsif loc == "NY-Bronx"
      "BXN"
    elsif loc == "TX-McAllen"
      "MCT"
    elsif loc == "CA-Fresno"
      "FRC"
    elsif loc == "CA-Bakersfield"
      "BKC"
    elsif loc == "AZ-Yuma"
      "YUZ"
    elsif loc == "US-Northeast"
      "US-NE"
    elsif loc == "US-Southeast"
      "US-SE"
    elsif loc == "US-Northwest"
      "US-NW"
    elsif loc == "US-Midwest"
      "US-MW"
    elsif loc == "US-Northeast (No Bronx)"
      "US-NE <br><span style='font-size: 8px'>No BXN</span>"
    else
      loc
    end
  end

  def generate_location(loc, lane=nil)
    if Carrier::LIGHT_BLUE.include?(loc)
      "<span class='badge badge-primary'>#{lane ? link_to(generate_abv(loc), lane) : generate_abv(loc)}</span>"
    elsif Carrier::DARK_BLUE.include?(loc)
      "<span class='badge badge-drakblue'>#{lane ? link_to(generate_abv(loc), lane) : generate_abv(loc)}</span>"
    elsif Carrier::BLUE.include?(loc)
      "<span class='badge badge-info'>#{lane ? link_to(generate_abv(loc), lane) : generate_abv(loc)}</span>"
    elsif Carrier::RED.include?(loc)
    "<span class='badge badge-danger'>#{lane ? link_to(generate_abv(loc), lane) : generate_abv(loc)}</span>"
    elsif Carrier::BROWN.include?(loc)
      "<span class='badge badge-brown'>#{lane ? link_to(generate_abv(loc), lane) : generate_abv(loc)}</span>"
    elsif Carrier::YELLOW.include?(loc)
      "<span class='badge badge-yellow'>#{lane ? link_to(generate_abv(loc), lane) : generate_abv(loc)}</span>"
    elsif Carrier::ORANGE.include?(loc)
      "<span class='badge badge-warning'>#{lane ? link_to(generate_abv(loc), lane) : generate_abv(loc)}</span>"
    elsif Carrier::GREEN.include?(loc)
      "<span class='badge badge-green'>#{lane ? link_to(generate_abv(loc), lane) : generate_abv(loc)}</span>"
    else
      ""
    end
  end

end
