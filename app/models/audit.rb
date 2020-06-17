Audit = Audited.audit_class

class Audit
  scope :today, -> do
    where("created_at >= ?", Time.zone.today.midnight).reorder('created_at DESC')
  end

  scope :overall, -> do
    select("audits.*, CONCAT(users.first_name, ' ', users.last_name) as user_name").joins("INNER JOIN users ON users.id = audits.user_id").reorder('created_at DESC')
  end

  def on_sentence(current_user=nil)
    @to_sentence = ""
    begin
      user = User.find(self.user_id)
      if !current_user.nil?
        if self.user_id == current_user.id
          @to_sentence = "You"
        else
          @to_sentence = user.first_name + " " + user.last_name
        end
      else
        @to_sentence = user.first_name + " " + user.last_name
      end
    rescue
      @to_sentence = "Unknown"
    end
    class_object_string = self.auditable_type.to_s
    if class_object_string.starts_with?('A', 'E', 'I', 'O', 'U', 'MasterInvoice')
      @string_article = "an"
    else
      @string_article = "a"
    end
    if self.action == "destroy"
      @to_sentence = @to_sentence + " removed " + @string_article  + " #{self.auditable_type == 'MasterInvoice' ? 'Invoice' : (self.auditable_type == 'MasterSignal' ? 'Signal' : self.auditable_type.titleize)}"
    else
      begin
        class_object = self.auditable_type.singularize.classify.constantize.find(self.auditable_id)
        @to_sentence = @to_sentence + " " + self.action + "d " + @string_article + " " + " #{class_object.display_name}"
      rescue
        @to_sentence = @to_sentence + " " + self.action + "d " + @string_article + " " + " #{self.auditable_type == 'MasterInvoice' ? 'Invoice' : (self.auditable_type == 'MasterSignal' ? 'Signal' : self.auditable_type.titleize)}"
      end
    end
    @to_sentence
  end
end
