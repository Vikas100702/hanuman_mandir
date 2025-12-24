import 'package:get/get.dart';
import 'package:hanuman_mandir/src/data/services/todays_panchangam/upcoming_events/upcoming_events_service.dart';
import 'package:hanuman_mandir/src/module/model/todays_panchangam/upcoming_events/upcoming_events_model.dart';

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

  /*List<Datum> get upcomingEventsDataList {
    final events = upcomingEventsDataModel.value?.data ?? [];

    if(events.isEmpty) return [];


  }*/
}
