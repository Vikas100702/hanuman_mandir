import 'package:get/get.dart';
import 'package:hanuman_mandir/src/data/services/header/header_service.dart';
import 'package:hanuman_mandir/src/module/model/header_model.dart';

class HeaderController extends GetxController {
  final HeaderService headerService;

  var isLoading = false.obs;
  var headerDataModel = Rxn<HeaderModel>();

  HeaderController({required this.headerService});

  @override
  void onInit() {
    super.onInit();
    fetchHeaderData();
  }

  Future<void> fetchHeaderData() async {
    try {
      isLoading(true);
      final result = await headerService.fetchHeaderSettingsData();

      if (result != null) {
        headerDataModel.value = result;
      } else {
        // Optional: Handle null case (e.g., show a snackbar)
        // Get.snackbar("Error", "Failed to fetch header data");
      }
    } catch (e) {
      throw Exception("Exception in HeaderController : $e");
    } finally {
      isLoading(false);
    }
  }

  List<Datum> get headerDataList => headerDataModel.value?.data ?? [];
}
