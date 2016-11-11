# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class SearchChannel < ApplicationCable::Channel
  def subscribed
    stream_from "search_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def index(message)
    ActionCable.server.broadcast("search_channel", message: message)
  end

  def search(query)
    client = Elasticsearch::Client.new
    es_result = client.search index: 'script_lines', body: { query: { match: { raw_text: query["query"] } }, size: 100 }
    results = es_result["hits"]["hits"].map{|hit| {script_id: hit["_source"]["script_id"], raw_text: hit["_source"]["raw_text"], episode_id: hit["_source"]["episode_id"]}}.uniq
    results.sort! {|a, b| a["episode_id"] <=> b["episode_id"]}
    results.each_with_index do |result, index|
      url = Episode.find_by(id: result[:episode_id]).image_url
      valid_url = url.match(/^(http:).*$/)
      if valid_url
        result[:image_url] = url
      else
        result[:image_url] = "http://esq.h-cdn.co/assets/15/28/980x490/landscape-1436378625-simpsons-trump-parody.jpg"
      end
    end
    ActionCable.server.broadcast("search_channel", message: results)
  end

end
