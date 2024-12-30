import 'package:flutter/material.dart';
import 'package:itunes/models/song.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioViewmodel extends ChangeNotifier {
  late AudioPlayer _audioPlayer;
  bool _isPlaying = false;
  final Song song;

  bool get isPlaying => _isPlaying;

  AudioViewmodel(this.song) {
    _audioPlayer = AudioPlayer();
  }

  void play() async {
    if (_isPlaying) {
      await _audioPlayer.pause();
    } else {
      await _audioPlayer.play(UrlSource(song.previewUrl));
    }
    _isPlaying = !_isPlaying;
    notifyListeners();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}
