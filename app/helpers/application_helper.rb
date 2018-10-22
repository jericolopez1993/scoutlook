module ApplicationHelper

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
    "#{location.name}<br/>#{location.address} #{location.city} #{location.state}, #{location.country} #{location.postal}".html_safe
  end

  def is_numeric?(obj)
   obj.to_s.match(/\A[+-]?\d+?(\.\d+)?\Z/) == nil ? false : true
  end

end
