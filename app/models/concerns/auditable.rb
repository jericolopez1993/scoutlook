module Auditable
  extend ActiveSupport::Concern

  included do

    after_save :save_log

    before_destroy :save_log

    private

    def class_name
      self.class.name
    end

    def current_action
      User.current_action ? User.current_action : nil
    end

    def current_user_id
      User.current ? User.current.id : nil
    end

    def main_id
      if self.has_attribute?(:carrier_id)
        return self.carrier_id
      elsif self.has_attribute?(:shipper_id)
        return self.shipper_id
      else
        return self.id
      end
    end

    def sub_id
      if self.has_attribute?(:carrier_id) || self.has_attribute?(:shipper_id)
        return self.id
      end
      return nil
    end

    def generate_description(current_user=nil)
      @to_sentence = ""
      begin
        user = User.find(current_user_id)
        if !current_user.nil?
          if current_user_id == current_user.id
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
      class_object_string = class_name.to_s
      if class_object_string.starts_with?('A', 'E', 'I', 'O', 'U', 'MasterInvoice')
        @string_article = "an"
      else
        @string_article = "a"
      end
      if current_action == "destroy"
        @to_sentence = @to_sentence + " removed " + @string_article  + " #{class_name == 'MasterInvoice' ? 'Invoice' : (class_name == 'MasterSignal' ? 'Signal' : class_name.titleize)}"
      else
        begin
          class_object = class_name.singularize.classify.constantize.find(self.id)
          @to_sentence = @to_sentence + " " + current_action + "d " + @string_article + " " + " #{class_object.display_name}"
        rescue
          @to_sentence = @to_sentence + " " + current_action + "d " + @string_article + " " + " #{class_name == 'MasterInvoice' ? 'Invoice' : (class_name == 'MasterSignal' ? 'Signal' : class_name.titleize)}"
        end
      end
      @to_sentence
    end

    def save_log
      if current_user_id
        Log.create(:model_type => class_name.to_s, :main_id => main_id, :sub_id => sub_id, :user_id => current_user_id, :action_name => current_action, :description => generate_description)
      end
    end
  end
end
