import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hanuman_mandir/src/data/services/special_events/special_events_service.dart';
import 'package:hanuman_mandir/src/module/controller/special_events/special_events_controller.dart';

class SpecialEventsView extends StatelessWidget {
  const SpecialEventsView({super.key});

  @override
  Widget build(BuildContext context) {
    final SpecialEventsController specialEventsController =
        Get.put(SpecialEventsController(specialEventsService: SpecialEventsService()));
    return Obx(() {
      if (specialEventsController.isLoading.value) {
        return const SizedBox(
          height: 250,
          child: Center(child: CircularProgressIndicator()),
        );
      }

      if (specialEventsController.specialEventsDataModel.value == null ||
          specialEventsController.specialEventsDataList.isEmpty) {
        return const SizedBox.shrink();
      }

      return LayoutBuilder(builder: (context, constraints){
        bool isMobile = constraints.maxWidth < 900;
        return Container(
          height: 200,
          width: 200,
          color: Colors.red,
        );
      });
    });
  }
}
