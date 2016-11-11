# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'

file = File.open(File.expand_path("./simpsons_characters.csv"))
# character_data = CSV.parse(Net::HTTP.get(URI.parse("https://www.kaggle.com/account/wcukierski/the-simpsons-by-the-data/downloads/simpsons_characters.csv"))
character_data = CSV.parse(file)
character_data.shift
Character.transaction do
  character_data.each do |character|
    Character.find_or_create_by(character_id: character[0], name: character[1], normalized_name: character[2], gender: character[3])
  end
end

puts ""
puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Characters loaded ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"

episode_data = CSV.parse(File.read(File.expand_path("./simpsons_episodes.csv")).gsub('"',"'"))
keys = episode_data.shift.map(&:to_sym)
Episode.transaction do
  episode_data.each do |episode|
    ep = Episode.new
    keys.each_with_index do |key, i|
      key = :episode_id if key == :id
      ep.write_attribute(key, episode[i])
    end
    ep.save
    print "."
  end
end

puts ""
puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Episodes loaded ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"


location_data = CSV.parse(File.read(File.expand_path("./simpsons_locations.csv")).gsub('"',"'"))
keys = location_data.shift.map(&:to_sym)
Location.transaction do
  location_data.each do |location|
    loc = Location.new
    keys.each_with_index do |key, i|
      key = :location_id if key == :id
      loc.write_attribute(key, location[i])
    end
    loc.save
    print "."
  end
end

puts ""
puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Locations loaded ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"

script_line_data = CSV.parse(File.read(File.expand_path("./simpsons_script_lines.csv")).gsub('"', "'"))
keys = script_line_data.shift - [nil]
keys.map!(&:to_sym)
ScriptLine.transaction do
  script_line_data.each do |script_line|
    script = ScriptLine.new
    keys.each_with_index do |key, i|
      key = :script_id if key == :id
      script.write_attribute(key, script_line[i])
    end
    script.save
    print "."
  end
end

puts ""
puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Scripts loaded ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
puts ""
puts "LOADED"
