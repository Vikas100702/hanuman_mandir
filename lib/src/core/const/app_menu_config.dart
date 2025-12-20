class MenuItemModel {
  final String title;
  final String routes;
  final bool hasDropdown;
  final bool isActive;

  MenuItemModel({
    required this.title,
    this.routes = '',
    this.hasDropdown = false,
    this.isActive = false,
  });
}

class AppMenuConfig {
  static List<MenuItemModel> mainMenuItems = [
    MenuItemModel(title: 'Home', isActive: true),
    MenuItemModel(title: 'Services'),
    MenuItemModel(title: 'Calendar'),
    MenuItemModel(title: 'Donations', hasDropdown: true),
    MenuItemModel(title: 'Events'),
    MenuItemModel(title: 'About Temple', hasDropdown: true),
    MenuItemModel(title: 'Sign-In'),
  ];
}
