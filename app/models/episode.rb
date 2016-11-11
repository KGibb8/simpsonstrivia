require 'elasticsearch/model'

class Episode < ApplicationRecord
  has_many_simpsons :script_lines
  has_many_simpsons :characters, through: :script_lines
  has_many_simpsons :locations, through: :script_lines
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
end
