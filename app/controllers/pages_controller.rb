class PagesController < ApplicationController
  def home
    @urls = Episode.find_by_sql("SELECT e.image_url FROM episodes AS e WHERE e.image_url IS NOT NULL LIMIT 51;").select{|ep| ep.image_url.to_i == 0}.map(&:image_url)
  end

  def trivia
    # 
  end
end
