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
      Date.parse(val.to_s).format("%d/%m/%Y")
    end
  end
end
