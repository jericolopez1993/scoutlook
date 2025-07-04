class AddNewCarrierToCarrierService
  def check_and_create
    mc_number_list = Carrier.all.pluck(:mc_number)
    carr_new = CarrNew.where('mcnum NOT IN (?) AND mc_number NOT IN (?)', mc_number_list, mc_number_list)
    user_names = CarrNew.all.pluck("Owner").uniq
    users = JSON.parse(User.select("users.id, users.first_name, users.last_name, CONCAT(users.first_name, ' ', users.last_name) AS full_name").where("CONCAT(users.first_name, ' ', users.last_name) IN (?)", user_names).to_json)
    carriers = []

    carr_new.each do |carr|
      user = users.select { |user| user['full_name'] == carr['owner'] }
      user_id = user.present? ? user['id'] : nil
      carriers.push({company_name: carr['carrier_name'], mc_number: carr['mc_number'], relationship_owner: user_id, phone: carr['phone1'], sales_priority: "U"})
    end
    Carrier.create(carriers)
  end

  def single_create(carr)
    if carr
      user = User.where("CONCAT(users.first_name, ' ', users.last_name) = ?", carr['owner'])
      user_id = user.present? ? user['id'] : nil
      Carrier.create(company_name: carr['carrier_name'], mc_number: carr['mc_number'], relationship_owner: user_id, phone: carr['phone1'], sales_priority: "U")
    end
  end

  def single_update(carr)
    if carr
      existing_carrer = Carrier.where(:mc_number => carr.mc_number).first
      user = User.where("CONCAT(users.first_name, ' ', users.last_name) = ?", carr['owner'])

      user_id = user.present? ? user['id'] : existing_carrer.relationship_owner
      company_name = carr['carrier_name']  ? carr['carrier_name'] : existing_carrer.company_name
      phone = carr['phone1'] ? carr['phone1'] : existing_carrer.phone

      existing_carrer.update(company_name: company_name, mc_number: carr['mc_number'], relationship_owner: user_id, phone: phone)
    end
  end

end
