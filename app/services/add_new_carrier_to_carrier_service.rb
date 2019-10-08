class AddNewCarrierToCarrierService
  def check_and_create
    mc_number_list = Carrier.all.pluck(:mc_number)
    carr_new = CarrNew.where('mcnum NOT IN (?)', mc_number_list)
    user_names = CarrNew.all.pluck("Owner").uniq
    users = JSON.parse(User.select("users.id, users.first_name, users.last_name, CONCAT(users.first_name, ' ', users.last_name) AS full_name").where("CONCAT(users.first_name, ' ', users.last_name) IN (?)", user_names).to_json)
    carriers = []
    
    carr_new.each do |carr|
      user = users.select { |user| user['full_name'] == carr['Owner'] }
      user_id = user.present? ? user['id'] : nil
      carriers.push({company_name: carr['Carrier_Name'], mc_number: carr['MC#'], relationship_owner: user_id, phone: carr['Phone#1'], sales_priority: "U"})
    end
    Carrier.create(carriers)
  end
end
