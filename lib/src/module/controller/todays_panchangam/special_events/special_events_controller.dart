import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hanuman_mandir/src/data/services/todays_panchangam/special_events/special_events_service.dart';
import 'package:hanuman_mandir/src/module/model/todays_panchangam/special_events/special_events_model.dart';
import 'package:intl/intl.dart';

class SpecialEventsController extends GetxController {
  final SpecialEventsService specialEventsService;

  var isLoading = false.obs;
  var specialEventsDataModel = Rxn<SpecialEventsModel>();

  SpecialEventsController({required this.specialEventsService});

  @override
  void onInit() {
    super.onInit();
    fetchSpecialEventsData();
  }

  Future<void> fetchSpecialEventsData() async {
    try {
      isLoading(true);
      final result = await specialEventsService.fetchSpecialEventsServiceData();

      if (result != null) {
        specialEventsDataModel.value = result;
      } else {
        // Todo : Optional: Handle null case (e.g., show a snackbar)
        // Get.snackbar("Error", "Failed to fetch Special events data");
      }
    } catch (e) {
      throw Exception("Exception in Special Events Controller : $e");
    } finally {
      isLoading(false);
    }
  }

  List<Datum> get specialEventsDataList {
    final events = specialEventsDataModel.value?.data ?? [];

    if(events.isEmpty) return [];

    // Get current date without time for accurate day-comparison
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    final dateFormat = DateFormat('MM/dd/yyyy');
    
    return events.where((event) {
      if(event.endDate == null || event.endDate!.isEmpty) return false;

      try {
        // Parsing 'MM/dd/yyyy' string to DateTime
        DateTime parsedDate = dateFormat.parse(event.endDate!);

        // Normalizing parsed date to 00:00:00(mid night)
        final eventEndDate = DateTime(parsedDate.year, parsedDate.month, parsedDate.day);

        // Keeping event if EndDate is Today or in the Future
        // !isBefore(today) is equivalent to >= today
        return !eventEndDate.isBefore(today);
      } catch(e) {
        // If the date string is malformed or doesn't match MM-dd-yyyy, hide the event
        debugPrint('Error parsing date for event ${event.id}: ${event.endDate}');
        return false;
      }
    }).toList();
  }
}
