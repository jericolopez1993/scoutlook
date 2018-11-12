class Rep < ApplicationRecord
  audited
  # before_create :set_rep_id
  #
  # def set_rep_id
  #   count = (Rep.all.length + 1).to_s.rjust(5, '0')
  #   str = self.last_name[0, 4].upcase
  #   self.rep_id = str + count
  # end
end
