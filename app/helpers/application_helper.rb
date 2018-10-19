module ApplicationHelper

  def generate_alphanumeric_id(str, id)
    count = id.to_s.rjust(5, '0')
    if str.nil?
      str = "NONM"
    end
    alp = str[0, 4].upcase
    alp + count
  end

  def convert_date(val)
    unless val.nil?
      Date.parse(val.to_s).strftime("%d/%m/%Y")
    end
  end

  def location_format(location)
    "#{location.name}<br/>#{location.address} #{location.city} #{location.state}, #{location.country} #{location.postal}".html_safe
  end
end
