class MoveAuditsServices
  def move
    logs = []
    audits = Audit.limit(5000)
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

      puts "#{{model_type: audit.auditable_type, main_id: main_id, sub_id: sub_id, user_id: audit.user_id, action_name: audit.action, description: audit.on_sentence}}"

      logs.push({model_type: audit.auditable_type, main_id: main_id, sub_id: sub_id, user_id: audit.user_id, action_name: audit.action, description: audit.on_sentence})
    end
    Log.create(logs)
    audits.delete_all
  end
end
