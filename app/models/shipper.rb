class Shipper < ApplicationRecord
  audited
  before_save :approved?
  has_many_attached :attachment_file
  after_destroy :remove_children

  belongs_to :relationship_owner_user, class_name: "User", foreign_key: "relationship_owner", optional: true

  has_many :locations, primary_key: "id", foreign_key: 'shipper_id', class_name: "ShipperLocation"
  has_many :shipper_lanes, :dependent => :delete_all
  has_many :messages, :dependent => :delete_all
  has_many :lane_1, -> { where(lane_priority: 1)}, primary_key: "id", foreign_key: 'shipper_id', class_name: "ShipperLane"
  has_many :lane_2, -> { where(lane_priority: 2)}, primary_key: "id", foreign_key: 'shipper_id', class_name: "ShipperLane"
  has_many :lane_3, -> { where(lane_priority: 3)}, primary_key: "id", foreign_key: 'shipper_id', class_name: "ShipperLane"
  has_many :activities, :dependent => :destroy
  has_many :rates, :dependent => :delete_all
  has_many :adm, -> { where(adm: true).order("id DESC")}, primary_key: "id", foreign_key: 'shipper_id', class_name: "ShipperContact"
  has_many :shipper_contacts, :dependent => :delete_all
  has_many :reminders, :dependent => :delete_all
  has_many :shipper_companies, :dependent => :delete_all

  has_one :origin_location, primary_key: "origin", foreign_key: 'id', class_name: "ShipperLocation"
  has_one :destination_location, primary_key: "destination", foreign_key: 'id', class_name: "ShipperLocation"
  has_one :head_office_location, primary_key: "head_office", foreign_key: 'id', class_name: "ShipperLocation"
  has_one :location, primary_key: "head_office", foreign_key: 'id', class_name: "ShipperLocation"
  has_one :poc, primary_key: "poc_id", foreign_key: 'id', class_name: "ShipperContact"
  has_one :pdm, primary_key: "pdm_id", foreign_key: 'id', class_name: "ShipperContact"

  scope :listings, -> {select("
      shippers.*,
      contacts.primary_phone,
      contacts.primary_phone_type,
      contacts.primary_extension_number,
      contacts.primary_eligible_texting,
      contacts.secondary_phone,
      contacts.secondary_phone_type,
      contacts.secondary_extension_number,
      contacts.secondary_eligible_texting,
      contacts.email as contact_email,
      locations.city,
      locations.address,
      locations.state,
      locations.country,
      locations.loc_type,
      (SELECT date_opened FROM activities WHERE activities.shipper_id = shippers.id ORDER BY created_at DESC LIMIT 1) as date_opened,
      CONCAT(relationship_owner_user.first_name, ' ', relationship_owner_user.last_name) as relationship_owner_name,
      CONCAT(contacts.first_name, ' ', contacts.last_name) as pdm_name,
      (SELECT cnactivities.campaign_name FROM activities AS cnactivities WHERE cnactivities.shipper_id =  shippers.id ORDER BY created_at DESC LIMIT 1) AS campaign_name,
      (SELECT atactivities.activity_type FROM activities AS atactivities WHERE atactivities.shipper_id =  shippers.id ORDER BY created_at DESC LIMIT 1) AS activity_type,
      (SELECT sactivities.status FROM activities AS sactivities WHERE sactivities.shipper_id =  shippers.id ORDER BY created_at DESC LIMIT 1) AS activity_status
    ").joins("
      LEFT JOIN users AS relationship_owner_user ON relationship_owner_user.id = shippers.relationship_owner
    ").joins("
      LEFT JOIN shipper_locations AS locations ON locations.id = shippers.head_office
    ").joins("
      LEFT JOIN shipper_contacts AS contacts ON contacts.id = shippers.pdm_id
    ")}

  scope :overall, ->(id) {where(:id => id).select("shippers.*, contacts.primary_phone, contacts.primary_phone_type, contacts.primary_extension_number, contacts.primary_eligible_texting, contacts.secondary_phone, contacts.secondary_phone_type, contacts.secondary_extension_number, contacts.secondary_eligible_texting, contacts.email as contact_email, locations.city, locations.address, locations.state, locations.country, locations.loc_type, (SELECT id FROM shipper_lanes WHERE shipper_lanes.shipper_id = shippers.id ORDER BY lane_priority DESC, created_at DESC LIMIT 1) AS lane_id, (SELECT lane_destination FROM shipper_lanes WHERE shipper_lanes.shipper_id = shippers.id ORDER BY lane_priority DESC, created_at DESC LIMIT 1) as lane_destination, (SELECT lane_origin FROM shipper_lanes WHERE shipper_lanes.shipper_id = shippers.id ORDER BY lane_priority DESC, created_at DESC LIMIT 1) as lane_origin, (SELECT date_opened FROM activities WHERE activities.shipper_id = shippers.id ORDER BY created_at DESC LIMIT 1) as date_opened, CONCAT(relationship_owner_user.first_name, ' ', relationship_owner_user.last_name) as relationship_owner_name, CONCAT(contacts.first_name, ' ', contacts.last_name) as pdm_name, (SELECT created_at FROM audits WHERE ((auditable_type = 'Shipper' AND auditable_id IN (shippers.id)) OR (auditable_type = 'ShipperCompany' AND auditable_id IN (SELECT shipper_companies.id FROM shipper_companies WHERE shipper_companies.shipper_id = shippers.id)) OR (auditable_type = 'ShipperContact' AND auditable_id IN (SELECT shipper_contacts.id FROM shipper_contacts WHERE shipper_contacts.shipper_id = shippers.id)) OR (auditable_type = 'ShipperLane' AND auditable_id IN (SELECT shipper_lanes.id FROM shipper_lanes WHERE shipper_lanes.shipper_id = shippers.id)) OR (auditable_type = 'ShipperLocation' AND auditable_id IN (SELECT shipper_locations.id FROM shipper_locations WHERE shipper_locations.shipper_id = shippers.id)) OR (auditable_type = 'Activity' AND auditable_id IN (SELECT activities.id FROM activities WHERE activities.shipper_id = shippers.id)) OR (auditable_type = 'Rate' AND auditable_id IN (SELECT rates.id FROM rates WHERE rates.shipper_id = shippers.id)) OR (auditable_type = 'Reminder' AND auditable_id IN (SELECT reminders.id FROM reminders WHERE reminders.shipper_id = shippers.id))) ORDER BY created_at DESC LIMIT 1) AS last_activity_date, (SELECT cnactivities.campaign_name FROM activities AS cnactivities WHERE cnactivities.shipper_id =  shippers.id ORDER BY created_at DESC LIMIT 1) AS campaign_name, (SELECT atactivities.activity_type FROM activities AS atactivities WHERE atactivities.shipper_id =  shippers.id ORDER BY created_at DESC LIMIT 1) AS activity_type, (SELECT sactivities.status FROM activities AS sactivities WHERE sactivities.shipper_id =  shippers.id ORDER BY created_at DESC LIMIT 1) AS activity_status").joins("LEFT JOIN users AS relationship_owner_user ON relationship_owner_user.id = shippers.relationship_owner").joins("LEFT JOIN shipper_locations AS locations ON locations.id = shippers.head_office").joins("LEFT JOIN shipper_contacts AS contacts ON contacts.id = shippers.pdm_id").limit(1)}

  default_scope {listings}

  COMMODITY = ["Mixed Fruits","Mixed Vegetables","Acorn Hard shell Squash","Aji Cachucha Pepper","Alfalfa","Alfalfa Sprout","Almond","Aloe Vera","Anaheim Pepper","Anise","Apple","Apricot","Arrow Root","Artichoke","Arugula","Ash Plantain Banana","Asian Cabbage","Asian Fruit","Asian Pear","Asian Vegetable","Asparagus","Atemoya","Avocado","Bac Ha","Bamboo Shoot","Banana","Banana Hard shell Squash","Banana Wax Pepper","Basil","Bay Leaf","Bean","Bedding Plant","Beefsteak Tomato","Beet","Beet Greens","Belgian Endive","Bell Pepper","Berries","Bibb Lettuce","Bitter gourd Melon","Bittermelon Melon","Black Bean","Blackberry","Black-Eyed Pea Bean","Blood Orange","Blueberry","Bok Choy","Boniato","Boston Lettuce","Boysenberry Berry","Braid Garlic","Brazil Nut","Bread Nut","Bread Nut Seeds","Breadfruit","Broccoflower","Broccoli","Broccoli Sprout","Brown Fig","Brussel Sprout","Buddha Hand","Bulb","Burro Banana","Butter Lettuce","Butternut Squash","Cabbage","Cabbage Celery","Calabaza Root","Calaloo","Candy","Cantaloupe","Carambola","Cardoon","Caribe Pepper","Carrot","Casaba Melon","Cashew","Cassava","Cauliflower","Cayenne Red Pepper","Celery","Celery Root","Chard","Chayote","Cheese","Cherimoya","Cherry","Cherry Plum","Cherry Tomato","Chervil","Chestnut","Chico Sapote","Chicory","Chili Dry Beans","Chili Pepper","Chinese Asian Cabbage","Chinese Dry Beans","Chinese Eggplant","Chinese Long Bean","Chinese Pea","Chinese Squash","Chipper Potato","Chive","Chocolate","Christmas Greens","Christmas Trees","Cilantro","Cipolline Onion","Citrus","Citrus Budwood","Clementine Mandarin","Cluster Tomato","Cocoa","Coconut","Coffee","Cole Slaw","Collard Greens","Corn","Courgette Squash","Couscous","Crab Apple","Cranberry","Crenshaw Melon","Crown Broccoli","Cubanelle Pepper","Cucumber","Culantro","Currant","Daikon","Dandelion Greens","Date","Deciduous Fruit","Diep Ca","Dill","Dominicos","Donqua Greens","Dosakai Cucumber","Dragon Fruit","Durian","Edamame","Edible Flower","Egg","Eggplant","Elephant Garlic","Endigia Lettuce","Endive","English Cucumber","English Pea","Escarole","Etrog","European Cucumber","Fava Bean","Feijoa","Fennel","Fenugreek","Fenugreek Seeds","Fiddlehead Fern","Fig","Filbert","Finger Hot Chili Pepper","Flower","Flower Banana","French Bean","Fresh Green Peanut","Fresno Pepper","Frisee","Fuji Apple","Gai Choy","Gai lan Kale","Galanga Root","Galia Melon","Garbanzo Bean","Garlic","Genip","Gift Basket","Ginger","Gobo Root","Gooseberry Berry","Gourd","Grape","Grape Tomato","Grapefruit","Greek Kiwifruit","Green Bean","Green Cabbage","Green Chili Pepper","Green Garlic","Green Mango","Green Onion","Green Papaya","Greens","Guacamole","Guaje","Guar Bean","Guava","Habanero Pepper","Hairy Mo Qua Squash","Hard shell Squash","Hawaiian Air Papaya","Hawaiian Plantain Banana","Hazelnut","Heart Celery","Heirloom Tomato","Hispanic Fruit","Hispanic Vegetable","Honey","Honeydew","Horned Melon","Horseradish","Horseradish Greens","Hot Jalapeno Pepper","Husk Sweet Corn","Indian Corn","Indian Eggplant","Inflorescent","Interspecific Apricot","Italian Chestnut","Italian Eggplant","Italian Prune","Italian Squash","Jack Fruit","Jalapeno Pepper","Japanese Cucumber","Japanese Eggplant","Jelly","Jicama","Juice Grape","Juice Orange","Jujube","Kabocha Hard shell Squash","Kale","Kantola","Key Lime","Kidney Bean","Kim Chee Greens","Kiwano","Kiwifruit","Kohlrabi","Kumquat","Leaf Banana","Leaf Lettuce","Leafy Vegetable","Leek","Legume","Lemon","Lemon Grass","Lentil Bean","Lettuce","Lily Root","Lima Bean","Lime","Long Bean","Longan","Loquat","Lotus Root","Lychee","Macadamia","Mache Lettuce","Malanga","Mamey","Mandarin","Mango","Mangosteen","Manzano Banana","Manzano Chili Pepper","Marion Blackberry","Marjoram","Matsutake Mushroom","Medjool Date","Melon","Mesclun","Mexican Chili Pepper","Mexican Key Lime","Mexican Squash","Micro Greens Greens","Minneola Orange","Mint","Mix Cole Slaw","Mo Qua Squash","Mocha Plantain Banana","Morel Mushroom","Mushroom","Mustard Greens","Nashi Asian Pear","Navel Orange","Nectarine","Nopales","Okinawa Sweet Potato","Okra","Olive","On choy","Ong Choy Spinach","Onion","Orange","Orange Bell Pepper","Oregano","Ornamental Corn","Ornamental Gourd","Ornamental Squash","Oyster Plant","Palm Heart","Papaya","Parsley","Parsnip","Parval Cucumber","Pasilla Pepper","Passionfruit","Pasta","Pea","Pea Bean","Peach","Peanut","Pear","Pearl Onion","Pecan","Pepper","Peppermint Mint","Persian Cucumber","Persian Lime","Persian Melon","Persimmon","Pickle Cucumber","Pickle Persian Cucumber","Pigeon Pea","Pimento","Pine Nut","Pineapple","Pinto Bean","Pistachio","Pitahaya","Plant","Plantain Banana","Plum","Plum Tomato","Plumcot","Pluot","Poblano Pepper","Pole Bean Bean","Pomegranate","Pomegranate Arils","Ponkan Mandarin","Poovan Banana","Popcorn Sweet Corn","Potato","Potato Salad","Preserves","Prickly Pear Cactus Pear","Processing Potato","Prune","Pummelo","Pumpkin","Pumpkin Seeds","Purple Bell Pepper","Quince","Rabe Broccoli","Radicchio","Radish","Raisin","Rambutan","Rape Greens","Rapini","Raspberry","Rau Day","Rau Ram","Red Banana","Red Bell Pepper","Red Cabbage","Red Currant","Red Fresno Pepper","Red Lettuce","Red Onion","Red Pepper","Regular Root Ginger","Relish","Rhubarb","Rice","Roma Tomato","Romaine Lettuce","Root","Root Asparagus","Root Ginger","Root Vegetable","Rosemary","Rutabaga","Sage","Salad","Sapodillo","Sapote","Savory","Savoy Cabbage","Scallion Green Onion","Scotch Bonnet Pepper","Seed Garlic","Seed Onion","Seed Potatoes","Seedless Cucumber","Seedless Watermelon","Serrano Pepper","Sesame Seeds","Set Onion","Shallot","Sherlihon Greens","Shiitake Mushroom","Sierra Fig","Snake Gourd Cucumber","Snap Bean","Snap Pea","Snap Sugar Pea","Snow Pea","Soft Fruit","Sorghum","Sorrel","Sour Cherry","Sour Orange Orange","Soybean Bean","Spaghetti Hard shell Squash","Spanish Onion","Spearmint Mint","Specialty Fruit","Specialty Vegetable","Spinach","Spring Mix","Sprout","Sprout Bean","Squash","Stalk Vegetables","Stone Fruit","Strawberry","Sugar Cane","Sugar Pea","Sunchokes","Sunflower Seed","Sweet Corn","Sweet Lime","Sweet Onion","Sweet Potato","Tamarillo","Tamarind","Tangelo","Tangerine","Taro Root","Tarragon","Teardrop Tomato","Temple Orange","Thai Basil","Thai Eggplant","Thai Pepper","Thai Root Ginger","Thyme","Tindora","Tofu","Tomatillo Tomato","Tomato","Tree Fruit","Tropical Fruit","Tropical Vegetable","Tuber","Turkey Brown Fig","Turmeric","Turnip","Turnip Greens","Valencia Orange","Valor Bean","Vine Fruit","Walnut","Water Coconut","Waterchestnut","Watercress","Watermelon","Wax Bean","Wheat Grass Sprout","White Bell Pepper","White Nectarine","White Onion","White Peach","Wine Grape","Winter Melon","Yam","Yampi Yam","Yellow Bell Pepper","Yellow Onion","Yellow Pepper","Yellow Squash","Yellow Tomato","Yellow Yam","Yu Choy Sum","Yuca Root","Zucchini Squash"]

  BLUE = ["NY", "NY-Brooklyn", "NY-Bronx",]
  LIGHT_BLUE = ["AL", "AK", "AR", "CO", "CT", "DE", "GA", "HI", "ID", "IL", "IN", "IA", "KS", "KY", "LA", "ME",
  "MD", "MA", "MI", "MN", "MS", "MO", "MT", "NE", "NH", "NJ", "NV", "NC", "ND", "OH", "OK", "OR", "PA", "RI", "SC", "SD",
  "TN", "UT", "VT", "VA", "WV", "WI", "WY",]
  DARK_BLUE = ["US-Northeast", "US-Northeast (No Bronx)", "US-Southeast", "US-Northwest", "US-Midwest",]
  BROWN = ["TX", "TX-McAllen"]
  ORANGE = ["CA", "CA-Fresno", "CA-Bakersfield", "AZ", "AZ-Yuma",]
  YELLOW = ["FL",]
  GREEN = ["WA",]
  RED = ["BC", "AB", "SK", "MB", "ON", "QC", "NB", "NS", "PEI", "NL", "NU",
  "NT", "YK",]



  def display_name
    if self.company_name.present? && self.company_name != "" && !self.company_name.nil?
      "Shipper (<a href='/shippers/#{self.id}'>#{self.company_name}</a>)"
    else
      "<a href='/shippers/#{self.id}'>Shipper</a>"
    end
  end

  def display_name_reminder
    if self.company_name.present? && self.company_name != "" && !self.company_name.nil?
      "<a href='/shippers/#{self.id}'>#{self.company_name}</a> (Shipper)"
    else
      "<a href='/shippers/#{self.id}'>Shipper</a>"
    end
  end


  def is_inbound?(location_id)
    ShipperLocation.where(:shipper_id => self.id, :location_id => location_id).length > 0
  end

  def shipper_type_to_array
    if self.shipper_type.nil?
      []
    else
      self.shipper_type.split(',').map(&:to_s)
    end
  end

  def commodities_to_array
    if self.commodities.nil?
      []
    else
      self.commodities.split(',').map(&:to_s)
    end
  end

  def last_contact_date
    Activity.where(:shipper_id => self.id).last
  end

  def rates
    activity_ids = self.activities.distinct(:id).pluck(:id).map(&:inspect).join(',')
    rates_shipper = Rate.where(shipper_id: self.id)
    if activity_ids != '' && rates_shipper.present?
      Rate.where("activity_id IN (#{activity_ids})").or(Rate.where(shipper_id: self.id))
    elsif activity_ids != '' && rates_shipper.blank?
      Rate.where("activity_id IN (#{activity_ids})")
    elsif activity_ids == '' && rates_shipper.present?
      Rate.where(shipper_id: self.id)
    else
      []
    end
  end

  private
    def remove_children
      ShipperContact.where(:shipper_id => self.id).destroy_all
      ShipperLocation.where(:shipper_id => self.id).destroy_all
    end
    def approved?
      if self.approved
        self.date_approved = Date.today
      end
    end
end
