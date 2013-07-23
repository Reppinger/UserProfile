class UserController < UIViewController
  attr_accessor :user

  def initWithUser(user)
    initWithNibName nil, bundle: nil
    self.user = user
    self
  end

  def viewDidLoad
    super
    self.view.backgroundColor = UIColor.whiteColor
    last_label = nil
    User::PROPERTIES.each do |property|
      last_label = create_property_title(last_label, property)
      self.view.addSubview last_label
      value = UILabel.alloc.initWithFrame(CGRectZero)
      value.text = self.user.send property
      value.sizeToFit
      value.frame = [
          [last_label.frame.origin.x + last_label.frame.size.width + 10,
           last_label.frame.origin.y],
          value.frame.size
      ]
      self.view.addSubview value
    end
    self.title = self.user.name
  end

  def create_property_title(last_label, property)
    label = UILabel.alloc.initWithFrame(CGRectZero)
    label.text = "#{property.capitalize}:"
    label.sizeToFit
    if last_label
      label.frame = [
          [last_label.frame.origin.x,
           last_label.frame.origin.y + last_label.frame.size.height],
          label.frame.size
      ]
    else
      label.frame = [[10, 10], label.frame.size]
    end
    label
  end
end