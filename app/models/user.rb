class User
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

  private
  def set_property(key, value)
    self.send("#{key}=", value)
  end

  def is_valid_property_name?(key)
    PROPERTIES.member? key.to_sym
  end

end