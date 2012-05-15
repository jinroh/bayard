require "json"
require "ostruct"

class Model < OpenStruct
  
  @@models = JSON.parse(File.read(FILE_NAME))

  def new_ostruct_member(name)
    name = name.to_sym
    unless self.respond_to?(name)
      class << self; self; end.class_eval do
        define_method(name) {
          v = @table[name]
          v.is_a?(Hash) ? Model.new(v) : v
        }
      end
    end
    name
  end

  def self.find(id)
    data = @@models[id.to_i] || @@models[0]
    Model.new(data)
  end

end