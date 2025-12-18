import 'package:flutter/material.dart';

import 'header/header_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hanuman Mandir"),
        backgroundColor: Colors.orange,
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            // Just call the Header Module here
            HeaderView(),

            // You can add other modules here in the future
            // Example: SliderView(),
            // Example: EventsView(),
          ],
        ),
      ),
    );
  }
}
