import 'package:get/get.dart';
import 'package:hanuman_mandir/src/data/services/about/about_service.dart';
import 'package:hanuman_mandir/src/module/model/about/about_model.dart';

class AboutController extends GetxController {
  final AboutService aboutService;

  var isLoading = false.obs;
  var aboutDataModel = Rxn<AboutModel>();

  AboutController({required this.aboutService});

  @override
  void onInit() {
    super.onInit();
    // fetchAboutData();
  }

  Future<void> fetchAboutData() async {
    try {
      isLoading(true);
      final result = await aboutService.fetchAboutServiceData();

      if (result != null) aboutDataModel.value = result;
    } catch (e) {
      throw Exception("Exception in About Controller : $e");
    } finally {
      isLoading(false);
    }
  }

  // Getter to access the full list of data
  List<AboutDatum> get aboutDataList => aboutDataModel.value?.data ?? [];
}
