import 'package:get/get.dart';
import 'package:hanuman_mandir/src/data/services/todays_panchangam/temple_schedule/temple_schedule_service.dart';
import 'package:hanuman_mandir/src/module/model/todays_panchangam/temple_schedule/temple_schedule_model.dart';

class TempleScheduleController extends GetxController {
  final TempleScheduleService templeScheduleService;

  var isLoading = false.obs;
  var templeScheduleDataModel = Rxn<TempleScheduleModel>();
  var selectedCategory = 'DAILY'.obs;

  TempleScheduleController({required this.templeScheduleService});

  @override
  void onInit() {
    super.onInit();
    fetchTempleScheduleData();
  }

  Future<void> fetchTempleScheduleData() async {
    try {
      isLoading(true);
      final result = await templeScheduleService
          .fetchTempleScheduleServiceData();

      if (result != null) {
        templeScheduleDataModel.value = result;
      } else {
        // Todo : Optional: Handle null case (e.g., show a snackbar)
        // Get.snackbar("Error", "Failed to fetch Temple Schedule data");
      }
    } catch (e) {
      throw Exception("Exception in Temple Schedule Controller : $e");
    } finally {
      isLoading(false);
    }
  }

  List<Datum> get _allData => templeScheduleDataModel.value?.data ?? [];

  List<Datum> get dailyList =>
      templeScheduleDataModel.value?.data
          .where((item) => item.scheduleType?.toLowerCase() == "daily")
          .toList() ??
      [];

  List<Datum> get weeklyList =>
      templeScheduleDataModel.value?.data
          .where((item) => item.scheduleType?.toLowerCase() == "weekly")
          .toList() ??
      [];

  List<Datum> get monthlyList =>
      templeScheduleDataModel.value?.data
          .where((item) => item.scheduleType?.toLowerCase() == "monthly")
          .toList() ??
      [];

  List<Datum> get currentDisplayList {
    switch (selectedCategory.value) {
      case "WEEKLY":
        return weeklyList;
      case "MONTHLY":
        return monthlyList;
      case "DAILY":
      default:
        return dailyList;
    }
  }

  void updateCategory(String category) {
    selectedCategory.value = category;
  }
}
