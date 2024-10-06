import 'package:flutter_tts/flutter_tts.dart';

class TtsHelper {
  static final FlutterTts flutterTts = FlutterTts();

  static Future<void> speak(String text) async {
    await flutterTts.awaitSpeakCompletion(true);
    await flutterTts.setLanguage("en-US");
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.setVolume(1.0);
    await flutterTts.setPitch(1.2);
    await flutterTts.speak(text);
  }

  static void stop() {
    flutterTts.stop();
  }
}
