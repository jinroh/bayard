require "json"
require "ostruct"

class Model < OpenStruct
  
  @@models = JSON.parse(File.read(DATA_FILE_NAME))

  def initialize(data)
    super(data)
    @data = data
  end

  def to_json
    @data.to_json
  end

  def new_ostruct_member(name)
    name = name.to_sym
    unless self.respond_to?(name)
      class << self; self; end.class_eval do
        define_method(name) do
          v = @table[name]
          v.is_a?(Hash) ? Model.new(v) : v
        end
      end
    end
    name
  end

  def self.find(id)
    data = @@models[id.to_i] || @@models[0]
    Model.new(data)
  end

end