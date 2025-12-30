import 'package:get/get.dart';
import 'package:hanuman_mandir/src/data/services/footer/footer_service.dart';
import 'package:hanuman_mandir/src/module/model/footer/footer_model.dart';

class FooterController extends GetxController {
  final FooterService footerService;
  var isLoading = false.obs;
  var footerDataModel = Rxn<FooterModel>();

  FooterController({required this.footerService});

  @override
  void onInit() {
    super.onInit();
    // fetchFooterData();
  }

  Future<void> fetchFooterData() async {
    try {
      isLoading(true);
      final result = await footerService.fetchFooterServiceData();

      if (result != null) {
        footerDataModel.value = result;
        } else {
          // Todo : Optional: Handle null case (e.g., show a snackbar)
          // Get.snackbar("Error", "Failed to fetch footer data");
        }
      } catch (e) {
        throw Exception("Exception in Footer Controller : $e");
      } finally {
        isLoading(false);
      }
  }

  List<Datum> get footerDataList => footerDataModel.value?.data ?? [];
}
