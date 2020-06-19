class MoveAuditsServices
  def move
    logs = []
    audits = Audit.where.not(:user_id => nil).order("created_at DESC").limit(10000)
    audits.each do |audit|
      main_id = nil
      sub_id = nil
      begin
        class_object = audit.auditable_type.singularize.classify.constantize.find(audit.auditable_id)

        if class_object.has_attribute?(:carrier_id)
           main_id = class_object.carrier_id
           sub_id = class_object.id
         elsif class_object.has_attribute?(:shipper_id)
            main_id = class_object.shipper_id
            sub_id = class_object.id
         else
            main_id = class_object.id
        end
      rescue
        class_object = audit.audited_changes

        if class_object.key?('carrier_id')
           main_id = class_object['carrier_id']
           sub_id = audit.auditable_id
         elsif class_object.key?('shipper_id')
            main_id = class_object['shipper_id']
            sub_id = audit.auditable_id
         else
            main_id = audit.auditable_id
        end
      end

      puts "#{{model_type: audit.auditable_type, main_id: main_id, sub_id: sub_id, user_id: audit.user_id, action_name: audit.action, description: audit.on_sentence, :created_at => audit.created_at.strftime("%Y-%m-%d %H:%m"), :updated_at => audit.created_at.strftime("%Y-%m-%d %H:%m")}}"

      logs.push({model_type: audit.auditable_type, main_id: main_id, sub_id: sub_id, user_id: audit.user_id, action_name: audit.action, description: audit.on_sentence, :created_at => audit.created_at.strftime("%Y-%m-%d %H:%m"), :updated_at => audit.created_at.strftime("%Y-%m-%d %H:%m")})
    end
    Log.create(logs)
    audits.delete_all
  end

  def update_description
    logs = Log.select("logs.*, CONCAT(users.first_name, ' ', users.last_name) as user_name").joins("INNER JOIN users ON users.id = logs.user_id").where.not(:user_id => nil, :sub_id => nil, :action_name => 'destroy')

    logs.each do |log|
      to_sentence = log.user_name
      class_name = log.model_type
      current_action = log.action_name
      class_object_string = log.model_type.to_s

      if class_object_string.starts_with?('A', 'E', 'I', 'O', 'U', 'MasterInvoice')
        string_article = "an"
      else
        string_article = "a"
      end

      begin
        class_object = log.model_type.singularize.classify.constantize.find(log.sub_id)
        to_sentence = to_sentence + " " + current_action + "d " + string_article + " " + "#{class_object.display_name}"
      rescue
        to_sentence = to_sentence + " " + current_action + "d " + string_article + " " + "#{class_name == 'MasterInvoice' ? 'Invoice' : (class_name == 'MasterSignal' ? 'Signal' : class_name.titleize)}"
      end
      puts "#{to_sentence}"
      log.update_attributes(:description => to_sentence)
    end
  end
end
