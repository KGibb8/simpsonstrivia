class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  # Takes in the symbol called
  def self.has_many_simpsons(foreign, options = {})
    foreign_string = foreign.to_s.end_with?("s") ? foreign.to_s[0..-2] : foreign.to_s
    constant = foreign_string.camelize
    key = self.to_s.downcase + '_id'
    unless options[:through].nil?
      self.send(:define_method, foreign) do
        return self.send(options[:through]).map(&foreign_string.to_sym)
      end
    else
      self.send(:define_method, foreign) do
        return Object.const_get(constant).where(key => self.send(key))
      end
    end
  end

  def self.belongs_to_simpsons foreign
    foreign_string = foreign.to_s
    # Transform to string such as "character_id" and turns back to symbol
    key = (foreign_string + "_id").to_sym
    # Camelize e.g. character to Character or script_line to ScriptLine
    constant = foreign_string.camelize
    # Sends a method to self, where foreign is the name of the method and the contents of the send block are the action.
    self.send(:define_method, foreign) do
      Object.const_get(constant).find_by(key => self.send(key))
    end
  end
end
