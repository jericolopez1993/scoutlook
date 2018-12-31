class Shipper < ApplicationRecord
  audited
  before_save :approved?
  has_many_attached :attachment_file
  after_destroy :remove_children

  COMMODITY = ["Acorn Hard shell Squash","Aji Cachucha Pepper","Alfalfa","Alfalfa Sprout","Almond","Aloe Vera","Anaheim Pepper","Anise","Apple","Apricot","Arrow Root","Artichoke","Arugula","Ash Plantain Banana","Asian Cabbage","Asian Fruit","Asian Pear","Asian Vegetable","Asparagus","Atemoya","Avocado","Bac Ha","Bamboo Shoot","Banana","Banana Hard shell Squash","Banana Wax Pepper","Basil","Bay Leaf","Bean","Bedding Plant","Beefsteak Tomato","Beet","Beet Greens","Belgian Endive","Bell Pepper","Berries","Bibb Lettuce","Bitter gourd Melon","Bittermelon Melon","Black Bean","Blackberry","Black-Eyed Pea Bean","Blood Orange","Blueberry","Bok Choy","Boniato","Boston Lettuce","Boysenberry Berry","Braid Garlic","Brazil Nut","Bread Nut","Bread Nut Seeds","Breadfruit","Broccoflower","Broccoli","Broccoli Sprout","Brown Fig","Brussel Sprout","Buddha Hand","Bulb","Burro Banana","Butter Lettuce","Butternut Squash","Cabbage","Cabbage Celery","Calabaza Root","Calaloo","Candy","Cantaloupe","Carambola","Cardoon","Caribe Pepper","Carrot","Casaba Melon","Cashew","Cassava","Cauliflower","Cayenne Red Pepper","Celery","Celery Root","Chard","Chayote","Cheese","Cherimoya","Cherry","Cherry Plum","Cherry Tomato","Chervil","Chestnut","Chico Sapote","Chicory","Chili Dry Beans","Chili Pepper","Chinese Asian Cabbage","Chinese Dry Beans","Chinese Eggplant","Chinese Long Bean","Chinese Pea","Chinese Squash","Chipper Potato","Chive","Chocolate","Christmas Greens","Christmas Trees","Cilantro","Cipolline Onion","Citrus","Citrus Budwood","Clementine Mandarin","Cluster Tomato","Cocoa","Coconut","Coffee","Cole Slaw","Collard Greens","Corn","Courgette Squash","Couscous","Crab Apple","Cranberry","Crenshaw Melon","Crown Broccoli","Cubanelle Pepper","Cucumber","Culantro","Currant","Daikon","Dandelion Greens","Date","Deciduous Fruit","Diep Ca","Dill","Dominicos","Donqua Greens","Dosakai Cucumber","Dragon Fruit","Durian","Edamame","Edible Flower","Egg","Eggplant","Elephant Garlic","Endigia Lettuce","Endive","English Cucumber","English Pea","Escarole","Etrog","European Cucumber","Fava Bean","Feijoa","Fennel","Fenugreek","Fenugreek Seeds","Fiddlehead Fern","Fig","Filbert","Finger Hot Chili Pepper","Flower","Flower Banana","French Bean","Fresh Green Peanut","Fresno Pepper","Frisee","Fuji Apple","Gai Choy","Gai lan Kale","Galanga Root","Galia Melon","Garbanzo Bean","Garlic","Genip","Gift Basket","Ginger","Gobo Root","Gooseberry Berry","Gourd","Grape","Grape Tomato","Grapefruit","Greek Kiwifruit","Green Bean","Green Cabbage","Green Chili Pepper","Green Garlic","Green Mango","Green Onion","Green Papaya","Greens","Guacamole","Guaje","Guar Bean","Guava","Habanero Pepper","Hairy Mo Qua Squash","Hard shell Squash","Hawaiian Air Papaya","Hawaiian Plantain Banana","Hazelnut","Heart Celery","Heirloom Tomato","Hispanic Fruit","Hispanic Vegetable","Honey","Honeydew","Horned Melon","Horseradish","Horseradish Greens","Hot Jalapeno Pepper","Husk Sweet Corn","Indian Corn","Indian Eggplant","Inflorescent","Interspecific Apricot","Italian Chestnut","Italian Eggplant","Italian Prune","Italian Squash","Jack Fruit","Jalapeno Pepper","Japanese Cucumber","Japanese Eggplant","Jelly","Jicama","Juice Grape","Juice Orange","Jujube","Kabocha Hard shell Squash","Kale","Kantola","Key Lime","Kidney Bean","Kim Chee Greens","Kiwano","Kiwifruit","Kohlrabi","Kumquat","Leaf Banana","Leaf Lettuce","Leafy Vegetable","Leek","Legume","Lemon","Lemon Grass","Lentil Bean","Lettuce","Lily Root","Lima Bean","Lime","Long Bean","Longan","Loquat","Lotus Root","Lychee","Macadamia","Mache Lettuce","Malanga","Mamey","Mandarin","Mango","Mangosteen","Manzano Banana","Manzano Chili Pepper","Marion Blackberry","Marjoram","Matsutake Mushroom","Medjool Date","Melon","Mesclun","Mexican Chili Pepper","Mexican Key Lime","Mexican Squash","Micro Greens Greens","Minneola Orange","Mint","Mix Cole Slaw","Mo Qua Squash","Mocha Plantain Banana","Morel Mushroom","Mushroom","Mustard Greens","Nashi Asian Pear","Navel Orange","Nectarine","Nopales","Okinawa Sweet Potato","Okra","Olive","On choy","Ong Choy Spinach","Onion","Orange","Orange Bell Pepper","Oregano","Ornamental Corn","Ornamental Gourd","Ornamental Squash","Oyster Plant","Palm Heart","Papaya","Parsley","Parsnip","Parval Cucumber","Pasilla Pepper","Passionfruit","Pasta","Pea","Pea Bean","Peach","Peanut","Pear","Pearl Onion","Pecan","Pepper","Peppermint Mint","Persian Cucumber","Persian Lime","Persian Melon","Persimmon","Pickle Cucumber","Pickle Persian Cucumber","Pigeon Pea","Pimento","Pine Nut","Pineapple","Pinto Bean","Pistachio","Pitahaya","Plant","Plantain Banana","Plum","Plum Tomato","Plumcot","Pluot","Poblano Pepper","Pole Bean Bean","Pomegranate","Pomegranate Arils","Ponkan Mandarin","Poovan Banana","Popcorn Sweet Corn","Potato","Potato Salad","Preserves","Prickly Pear Cactus Pear","Processing Potato","Prune","Pummelo","Pumpkin","Pumpkin Seeds","Purple Bell Pepper","Quince","Rabe Broccoli","Radicchio","Radish","Raisin","Rambutan","Rape Greens","Rapini","Raspberry","Rau Day","Rau Ram","Red Banana","Red Bell Pepper","Red Cabbage","Red Currant","Red Fresno Pepper","Red Lettuce","Red Onion","Red Pepper","Regular Root Ginger","Relish","Rhubarb","Rice","Roma Tomato","Romaine Lettuce","Root","Root Asparagus","Root Ginger","Root Vegetable","Rosemary","Rutabaga","Sage","Salad","Sapodillo","Sapote","Savory","Savoy Cabbage","Scallion Green Onion","Scotch Bonnet Pepper","Seed Garlic","Seed Onion","Seed Potatoes","Seedless Cucumber","Seedless Watermelon","Serrano Pepper","Sesame Seeds","Set Onion","Shallot","Sherlihon Greens","Shiitake Mushroom","Sierra Fig","Snake Gourd Cucumber","Snap Bean","Snap Pea","Snap Sugar Pea","Snow Pea","Soft Fruit","Sorghum","Sorrel","Sour Cherry","Sour Orange Orange","Soybean Bean","Spaghetti Hard shell Squash","Spanish Onion","Spearmint Mint","Specialty Fruit","Specialty Vegetable","Spinach","Spring Mix","Sprout","Sprout Bean","Squash","Stalk Vegetables","Stone Fruit","Strawberry","Sugar Cane","Sugar Pea","Sunchokes","Sunflower Seed","Sweet Corn","Sweet Lime","Sweet Onion","Sweet Potato","Tamarillo","Tamarind","Tangelo","Tangerine","Taro Root","Tarragon","Teardrop Tomato","Temple Orange","Thai Basil","Thai Eggplant","Thai Pepper","Thai Root Ginger","Thyme","Tindora","Tofu","Tomatillo Tomato","Tomato","Tree Fruit","Tropical Fruit","Tropical Vegetable","Tuber","Turkey Brown Fig","Turmeric","Turnip","Turnip Greens","Valencia Orange","Valor Bean","Vine Fruit","Walnut","Water Coconut","Waterchestnut","Watercress","Watermelon","Wax Bean","Wheat Grass Sprout","White Bell Pepper","White Nectarine","White Onion","White Peach","Wine Grape","Winter Melon","Yam","Yampi Yam","Yellow Bell Pepper","Yellow Onion","Yellow Pepper","Yellow Squash","Yellow Tomato","Yellow Yam","Yu Choy Sum","Yuca Root","Zucchini Squash"]

  def display_name
    if self.company_name.present? && self.company_name != "" && !self.company_name.nil?
      "Shipper (<a href='/shippers/#{self.id}'>#{self.company_name}</a>)"
    else
      "<a href='/shippers/#{self.id}'>Shipper</a>"
    end
  end

  def relationship_owner_user
    begin
      User.find(self.relationship_owner)
    rescue
      nil
    end
  end

  def locations
    ShipperLocation.where(:shipper_id => self.id)
  end

  def shipper_lanes
    ShipperLane.where(:shipper_id => self.id)
  end

  def shipper_activities
    ShipperActivity.where(:shipper_id => self.id)
  end

  def lane_1
    ShipperLane.where(:shipper_id => self.id, :lane_priority => 1)
  end

  def lane_2
    ShipperLane.where(:shipper_id => self.id, :lane_priority => 2)
  end

  def lane_3
    ShipperLane.where(:shipper_id => self.id, :lane_priority => 3)
  end

  def default_location
      if !self.origin.nil?
        ShipperLocation.find(self.origin).location
      elsif !self.head_office.nil?
        ShipperLocation.find(self.head_office).location
      elsif ShipperLocation.all.length > 0
        ShipperLocation.first.location
      else
        nil
      end
  end

  def origin_location
    begin
      ShipperLocation.find(self.origin)
    rescue
      nil
    end
  end

  def destination_location
    begin
      ShipperLocation.find(self.destination)
    rescue
      nil
    end
  end

  def head_office_location
    begin
      ShipperLocation.find(self.head_office)
    rescue
      nil
    end
  end

  def location
    begin
      ShipperLocation.find(self.head_office)
    rescue
      nil
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

  def poc
    if self.poc_id.present? && !self.poc_id.nil?
      ShipperContact.find(self.poc_id)
    else
      nil
    end
  end

  def pdm
    if self.pdm_id.present? && !self.pdm_id.nil?
      ShipperContact.find(self.pdm_id)
    else
      nil
    end
  end

  def adm
    ShipperContact.where(:shipper_id => self.id, :adm => true).order("id DESC")
  end

  def last_contact_by_rep
    if self.last_contact_by.present? && !self.last_contact_by.nil?
      Rep.find(self.last_contact_by)
    else
      nil
    end
  end

  def last_contact_date
    ShipperActivity.where(:shipper_id => self.id).last
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
