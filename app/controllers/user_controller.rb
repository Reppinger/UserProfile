class UserController < UIViewController
  include BubbleWrap::KVO

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
      value_label = create_property_value(last_label, property)
      self.view.addSubview value_label
    end
    setup_title
  end

  def viewDidUnload
    unobserve_all
    super
  end

  private

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

  def create_property_value(last_label, property)
    value = UILabel.alloc.initWithFrame(CGRectZero)
    value.text = self.user.send property
    value.sizeToFit
    set_up_observer(property, value)
    value.frame = [
        [last_label.frame.origin.x + last_label.frame.size.width + 10,
         last_label.frame.origin.y],
        value.frame.size
    ]
    value
  end

  def setup_title
    self.title = self.user.name
    observe(self.user, 'name') do |old_value, new_value|
      self.title = new_value
    end
  end

  def set_up_observer(property, value)
    observe(self.user, property) do |old_value, new_value|
      value.text = new_value
      value.sizeToFit
    end
  end

end
