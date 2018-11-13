Audit = Audited.audit_class

class Audit
  scope :today, -> do
    where("created_at >= ?", Time.zone.today.midnight).reorder(:created_at)
  end

  def on_sentence
    @to_sentence = ""
    begin
      user = User.find(self.user_id)
      @to_sentence = user.first_name + " " + user.last_name
    rescue
      @to_sentence = "Unknown"
    end

    class_object = self.auditable_type.singularize.classify.constantize.find(self.auditable_id)
    @to_sentence = @to_sentence + " " + self.action + " an #{class_object.display_name}"

    @to_sentence
  end
end
