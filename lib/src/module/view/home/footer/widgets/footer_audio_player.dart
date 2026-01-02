import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hanuman_mandir/src/core/const/endpoints/endpoints.dart';
import 'package:hanuman_mandir/src/data/services/background_music_service/background_music_service.dart';
import 'package:hanuman_mandir/src/module/controller/background_music/background_music_controller.dart';
import 'package:hanuman_mandir/src/module/model/background_music/background_music_model.dart';
import 'package:intl/intl.dart';
import 'package:just_audio/just_audio.dart';

class FooterAudioPlayer extends StatefulWidget {
  const FooterAudioPlayer({super.key});

  @override
  State<FooterAudioPlayer> createState() => _FooterAudioPlayerState();
}

class _FooterAudioPlayerState extends State<FooterAudioPlayer> {
  final BackgroundMusicController _backgroundMusicController = Get.find<BackgroundMusicController>();

  final AudioPlayer _audioPlayer = AudioPlayer();

  bool _isPlaying = false;
  String? _currentUrl;

  @override
  void initState() {
    super.initState();
    _initAudio();
  }

  void _initAudio() {
    // 1. Listen to data changes to load music once fetched
    ever(_backgroundMusicController.backgroundMusicDataModel, (
      BackgroundMusicModel? model,
    ) {
      if (model != null) {
        _loadTodaysMusic(model);
      }
    });

    // If data is already there (rare race condition, but good safety)
    if (_backgroundMusicController.backgroundMusicDataModel.value != null) {
      _loadTodaysMusic(
        _backgroundMusicController.backgroundMusicDataModel.value!,
      );
    }
  }

  void _loadTodaysMusic(BackgroundMusicModel model) async {
    //Get System Day
    String today = DateFormat('EEEE').format(DateTime.now());

    // Find matching entry in data
    var musicEntry = model.data.firstWhereOrNull(
      (element) => element.dayName?.toLowerCase() == today.toLowerCase(),
    );

    if (musicEntry != null && musicEntry.refDataName != null) {
      try {
        _currentUrl =
            "${Endpoints.globalUrl}${musicEntry.refDataName}";
        await _audioPlayer.setUrl(_currentUrl!);
      } catch (e) {
        debugPrint("Error loading audio: $e");
      }
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 45,
      decoration: BoxDecoration(
        color: const Color(0xFF901B2B),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white54, width: 1),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          // Play / Pause button
          GestureDetector(
            onTap: () {
              if (_currentUrl == null) return;
              if (_isPlaying) {
                _audioPlayer.pause();
              } else {
                _audioPlayer.play();
              }

              setState(() {
                _isPlaying = !_isPlaying;
              });
            },

            child: Icon(
              _isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
              color: Color(0xFFFFFFFF),
              size: 24,
            ),
          ),

          // Slider / Progress of audio
          Expanded(
            child: StreamBuilder(
              stream: _audioPlayer.positionStream,
              builder: (context, snapshot) {
                final position = snapshot.data ?? Duration.zero;
                final duration = _audioPlayer.duration ?? Duration.zero;

                double sliderValue = position.inSeconds.toDouble();
                double maxValue = duration.inSeconds.toDouble();

                if (sliderValue > maxValue) sliderValue = maxValue;

                return SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    thumbShape: const RoundSliderThumbShape(
                      enabledThumbRadius: 6,
                    ),
                    overlayShape: const RoundSliderOverlayShape(
                      overlayRadius: 10,
                    ),
                    trackHeight: 2,
                    activeTrackColor: Color(0xFFFFFFFF),
                    inactiveTrackColor: Color(0x3DFFFFFF),
                    thumbColor: Color(0xFFFFFFFF),
                  ),
                  child: Slider(
                    value: sliderValue,
                    min: 0,
                    max: maxValue > 0 ? maxValue : 1,
                    onChanged: (val) {
                      _audioPlayer.seek(Duration(seconds: val.toInt()));
                    },
                  ),
                );
              },
            ),
          ),
          
          const Icon(Icons.volume_up_rounded, size: 20, color: Color(0xFFFFFFFF),)
        ],
      ),
    );
  }
}
