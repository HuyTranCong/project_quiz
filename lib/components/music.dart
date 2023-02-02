import 'package:assets_audio_player/assets_audio_player.dart';

class Music {
  static AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer();
  static Future init() async {
    await assetsAudioPlayer.open(
      Audio('assets/music/quiz.mp3'),
      autoStart: true,
      showNotification: true,
    );
    await assetsAudioPlayer.play();
    await assetsAudioPlayer.setLoopMode(LoopMode.single);
  }
}
