import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:hanuman_mandir/src/data/services/todays_panchangam/upcoming_events/upcoming_events_service.dart';
import 'package:hanuman_mandir/src/module/model/todays_panchangam/upcoming_events/upcoming_events_model.dart';
import 'package:intl/intl.dart';

class UpcomingEventsController extends GetxController {
  final UpcomingEventsService upcomingEventsService;

  var isLoading = false.obs;
  var upcomingEventsDataModel = Rxn<UpcomingEventsModel>();

  UpcomingEventsController({required this.upcomingEventsService});

  @override
  void onInit() {
    super.onInit();
    fetchUpcomingEventsData();
  }

  Future<void> fetchUpcomingEventsData() async {
    try {
      isLoading(true);
      final result = await upcomingEventsService
          .fetchUpcomingEventsServiceData();

      if (result != null) {
        upcomingEventsDataModel.value = result;
      } else {
        // Todo : Optional: Handle null case (e.g., show a snackbar)
        // Get.snackbar("Error", "Failed to fetch Upcoming Events data");
      }
    } catch (e) {
      throw Exception("Exception in Upcoming Events Controller : $e");
    } finally {
      isLoading(false);
    }
  }

  List<Datum> get upcomingEventsDataList {
    final events = upcomingEventsDataModel.value?.data ?? [];

    if (events.isEmpty) return [];

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    final dateFormat = DateFormat("MM/dd/yyyy");

    return events.where((event) {
      // if (event.startDate == null || event.startDate!.isEmpty) return false;
      if (event.endDate == null || event.endDate!.isEmpty) return false;

      try {
        // Parsing 'MM/dd/yyyy' string to DateTime
        // DateTime parsedDate = dateFormat.parse(event.startDate!);
        DateTime parsedDate = dateFormat.parse(event.endDate!);

        // Normalizing parsed date to 00:00:00(mid night)
        final eventStartDate = DateTime(
          parsedDate.year,
          parsedDate.month,
          parsedDate.day,
        );
        final eventEndDate = DateTime(
          parsedDate.year,
          parsedDate.month,
          parsedDate.day,
        );

        // Keeping event if StartDate is Today or in the Future
        // !isBefore(today) is equivalent to >= today
        return !eventEndDate.isBefore(today);
      } catch (e) {
        // If the date string is malformed or doesn't match MM-dd-yyyy, hide the event
        debugPrint(
          'Error parsing date for event ${event.id}: ${event.endDate}',
        );
        return false;
      }
    }).toList();
  }
}
