class AddNewCarrierToCarrierService
  def check_and_create
    mc_number_list = Carrier.all.pluck(:mc_number)
    carr_new = CarrNew.where('mcnum NOT IN (?)', mc_number_list)
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
end
