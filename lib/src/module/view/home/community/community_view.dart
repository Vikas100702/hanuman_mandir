import 'package:flutter/material.dart';
import 'package:hanuman_mandir/src/core/utils/style_extension.dart';
import 'package:hanuman_mandir/src/module/view/home/community/widgets/community_widgets.dart';

class CommunityView extends StatelessWidget {
  const CommunityView({super.key});

  @override
  Widget build(BuildContext context) {
    Widget eventCalendarCard = CommunityWidgets.communityCard(
      context,
      title: "Event Calendar",
      description:
          "Explore Sri Hanuman Mandir Event Calendar: daily, monthly, and yearly Hindu religious events. You can download our full annual calendar.",
      buttonText: "View Calendar",
      imagePath: "assets/images/DSC0114.jpg",
      onTap: () {},
    );

    Widget subscribeCard = CommunityWidgets.communityCard(
      context,
      title: "Subscribe",
      description:
          "The Sri Hanuman Mandir is fully dedicated in its mission of providing Hindu religious services to its devotee community.",
      buttonText: "SUBSCRIBE",
      imagePath: "assets/images/Subscribe.jpg",
      onTap: () {},
    );
    if (context.isMobile) {
      return Column(children: [eventCalendarCard, subscribeCard]);
    } else {
      return Row(children: [Expanded(child: eventCalendarCard), Expanded(child: subscribeCard)]);
    }
  }
}
