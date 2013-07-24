class User
  USER_KEY = 'user'

  PROPERTIES = [:id, :name, :email, :phone]
  PROPERTIES.each do |prop|
    attr_accessor prop
  end

  def initialize(properties = {})
    properties.each do |key, value|
      if is_valid_property_name?(key)
        set_property key, value
      end
    end
  end

  def initWithCoder(decoder)
    self.init
    PROPERTIES.each do |property|
      saved_value = decoder.decodeObjectForKey property.to_s
      self.send("#{property}=", saved_value)
    end
    self
  end

  def encodeWithCoder(encoder)
    PROPERTIES.each do |property|
      encoder.encodeObject(self.send(property), forKey: property.to_s)
    end
  end

  def save
    defaults = NSUserDefaults.standardUserDefaults
    defaults[USER_KEY] = NSKeyedArchiver.archivedDataWithRootObject(self)
  end

  def self.load
    defaults = NSUserDefaults.standardUserDefaults
    data = defaults[USER_KEY]
    NSKeyedUnarchiver.unarchiveObjectWithData(data) if data
  end

  private
  def set_property(key, value)
    self.send("#{key}=", value)
  end

  def is_valid_property_name?(key)
    PROPERTIES.member? key.to_sym
  end

end