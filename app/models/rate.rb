class Rate < ApplicationRecord
  has_one_attached :supporting_pdf

  def rep
    if !self.rep_id.nil?
      Rep.find(self.rep_id)
    else
      nil
    end
  end
  def client
    if !self.client_id.nil?
      Client.find(self.client_id)
    else
      nil
    end
  end
  def parent
    if !self.parent_id.nil?
      Rate.find(self.parent_id)
    else
      nil
    end
  end
end
