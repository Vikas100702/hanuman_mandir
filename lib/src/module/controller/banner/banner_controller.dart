import 'package:get/get.dart';
import 'package:hanuman_mandir/src/data/services/banner/banner_service.dart';
import 'package:hanuman_mandir/src/module/model/banner/banner_model.dart';

class BannerController extends GetxController {
  final BannerService bannerService;

  var isLoading = false.obs;
  var bannerDataModel = Rxn<BannerModel>();

  BannerController({required this.bannerService});

  @override
  void onInit() {
    super.onInit();
    fetchBannerData();
  }

  Future<void> fetchBannerData() async {
    try {
      isLoading(true);
      final result = await bannerService.fetchBannerServiceData();

      if (result != null) {
        bannerDataModel.value = result;
      } else {
        // Todo : Optional: Handle null case (e.g., show a snackbar)
        // Get.snackbar("Error", "Failed to fetch header data");
      }
    } catch (e) {
      throw Exception("Exception in HeaderController : $e");
    } finally {
      isLoading(false);
    }
  }

  List<Datum> get bannerDataList => bannerDataModel.value?.data ?? [];
}
