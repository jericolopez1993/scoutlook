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
      Date.parse(val.to_s).strftime("%d/%m/%Y")
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

  def get_distance(origin_id, destination_id)
    distance = 0
    if (!origin_id.nil? && !destination_id.nil?) && (origin_id != "" && destination_id != "")
      origin = Location.find(origin_id)
      @origin = origin.address + " " + origin.state + "," + origin.country
      destination = Location.find(destination_id)
      @destination = destination.address + " " +destination.state + "," + destination.country
      begin
        str_url = "https://maps.googleapis.com/maps/api/distancematrix/json?&origins=" + @origin + "&destinations=" + @destination + "&key=AIzaSyCbFFNkesD-8_F4lMdyihwqpARlDYmG6k0"
        response = HTTParty.get(str_url)
        body = JSON.parse(response.body)
        temp_distance =  body['rows'][0]['elements'][0]['distance']['value'].nil? ? 0 :  body['rows'][0]['elements'][0]['distance']['value']
        distance = temp_distance / 1000
      rescue
        puts 'Google Maps API error'
        distance
      end
    else
      distance
    end
  end

  def get_map(origin_id, destination_id)
    require 'uri'

    @origin = ""
    @destination = ""

    if origin_id.present? && origin_id != ""
      origin = Location.find(params[:origin])
      @origin = origin.address + " " + origin.state + "," + origin.country
    end

    if destination_id.present? && destination_id != ""
      destination = Location.find(params[:destination])
      @destination = destination.address + " " +destination.state + "," + destination.country
    end

    URI.parse("https://maps.googleapis.com/maps/api/staticmap?size=512x512&maptype=roadmap\&markers=size:mid%7Ccolor:red%7C#{@origin}%7C#{@destination}&key=AIzaSyCbFFNkesD-8_F4lMdyihwqpARlDYmG6k0")
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

end
