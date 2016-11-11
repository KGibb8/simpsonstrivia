require 'elasticsearch/model'

class ScriptLine < ApplicationRecord
  belongs_to_simpsons :character
  belongs_to_simpsons :location
  belongs_to_simpsons :episode
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
end
