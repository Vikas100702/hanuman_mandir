import 'package:get/get.dart';
import 'package:hanuman_mandir/src/data/services/todays_panchangam/special_events/special_events_service.dart';
import 'package:hanuman_mandir/src/module/model/todays_panchangam/special_events/special_events_model.dart';

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

  List<Datum> get specialEventsDataList =>
      specialEventsDataModel.value?.data ?? [];
}
