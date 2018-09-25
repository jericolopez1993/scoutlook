module ApplicationHelper

  def generate_alphanumeric_id(str, id)
    count = id.to_s.rjust(5, '0')
    alp = str[0, 4].upcase
    alp + count
  end
end
