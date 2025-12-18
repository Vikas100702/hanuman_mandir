import 'package:flutter/material.dart';
import 'package:hanuman_mandir/src/module/view/banner/banner_view.dart';

import 'header/header_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const SingleChildScrollView(
        child: Column(
          children: [
            // Just call the Header Module here
            HeaderView(),
            BannerView(),

            // You can add other modules here in the future
            // Example: SliderView(),
            // Example: EventsView(),
          ],
        ),
      ),
    );
  }
}
