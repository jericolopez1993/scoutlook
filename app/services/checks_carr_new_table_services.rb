class ChecksCarrNewTableServices
  def check_and_create
    carr_news = CarrNew.where("first_load_date < NOW() - INTERVAL '4 WEEK' AND interview")
    carr_news.destroy_all
  end

  def check_and_move
    sl_carr_news = SlCarrNew.all.pluck(:mc_number)
    sl_carr_new_names = SlCarrNew.all.pluck(:carrier_name)
    if sl_carr_news.length > 0
      carr_news = CarrNew.where('mc_number NOT IN (?) AND carrier_name NOT IN (?)', sl_carr_news, sl_carr_new_names)
    else
      carr_news = CarrNew.all
    end

    SlCarrNew.create(carr_news.as_json)
  end
end
