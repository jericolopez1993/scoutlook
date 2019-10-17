class ChecksCarrNewTableServices
  def check_and_create
    carr_news = CarrNew.where("first_load_date < NOW() - INTERVAL '4 WEEK' AND interview")
    carr_news.destroy_all
  end
end
