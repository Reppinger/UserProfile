class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    user_controller = create_user_controller
    nav_controller = create_root_view_controller user_controller
    create_main_window nav_controller
    true
  end

  def create_user_controller
    user = User.new(id: '123', name: 'Clay', email: 'clay@mail.com', phone: '555-555-5555')
    UserController.alloc.initWithUser user
  end

  def create_root_view_controller(user_controller)
    UINavigationController.alloc.initWithRootViewController user_controller
  end

  def create_main_window(rootViewController)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.rootViewController = rootViewController
    @window.makeKeyAndVisible
  end
end
