import 'package:flutter/cupertino.dart';

class ResponsiveView extends StatelessWidget {
  final Widget mobile;
  final Widget desktop;
  final Widget? tablet;

  const ResponsiveView({
    super.key,
    required this.mobile,
    required this.desktop,
    this.tablet,
  });

  // Static helper to check device type anywhere
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 900;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 900) {
          return desktop;
        } else {
          // If tablet isn't provided, fallback to mobile
          return mobile;
        }
      },
    );
  }
}
