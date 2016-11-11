require 'elasticsearch/model'

class Character < ApplicationRecord
  has_many_simpsons :script_lines
  has_many_simpsons :episodes, through: :script_lines
  has_many_simpsons :locations, through: :script_lines
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
end
