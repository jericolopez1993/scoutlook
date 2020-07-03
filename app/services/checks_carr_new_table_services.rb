class ChecksCarrNewTableServices
  def check_and_create
    carr_news = CarrNew.where("first_load_date < NOW() - INTERVAL '4 WEEK' AND interview")
    carr_news.destroy_all
  end

  def check_and_move
    sl_carr_news = SlCarrNew.all.pluck(:mcnum)
    if sl_carr_news.length > 0
      carr_news = CarrNew.where.not('mcnum NOT IN (?)', sl_carr_news)
    else
      carr_news = CarrNew.all
    end

    SlCarrNew.create(carr_news.as_json)
  end
end
