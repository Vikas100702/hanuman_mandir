import 'package:get/get.dart';
import 'package:hanuman_mandir/src/data/services/background_music_service/background_music_service.dart';
import 'package:hanuman_mandir/src/module/model/background_music/background_music_model.dart';

class BackgroundMusicController extends GetxController {
  final BackgroundMusicService backgroundMusicService;

  var isLoading = false.obs;
  var backgroundMusicDataModel = Rxn<BackgroundMusicModel>();

  BackgroundMusicController({required this.backgroundMusicService});

  @override
  void onInit() {
    super.onInit();
    // fetchBackgroundMusicData();
  }

  Future<void> fetchBackgroundMusicData() async {
    try {
      isLoading(true);
      final result = await backgroundMusicService
          .fetchBackgroundMusicServiceData();

      if (result != null) {
        backgroundMusicDataModel.value = result;
      } else {
        // Todo : Optional: Handle null case (e.g., show a snackbar)
        // Get.snackbar("Error", "Failed to fetch background music data");
      }
    } catch (e) {
      throw Exception("Exception in BackgroundMusic Controller : $e");
    } finally {
      isLoading(false);
    }
  }
}
