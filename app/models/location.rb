require 'elasticsearch/model'

class Location < ApplicationRecord
  has_many_simpsons :script_lines
  has_many_simpsons :characters, through: :script_lines
  has_many_simpsons :episodes, through: :script_lines
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
end
