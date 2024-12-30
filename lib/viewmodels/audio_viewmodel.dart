import 'package:flutter/material.dart';
import 'package:itunes/models/song.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioViewmodel extends ChangeNotifier {
  late AudioPlayer _audioPlayer;
  bool _isPlaying = false;
  bool _isRepeat = false;
  final List<Song> songs;
  int index;

  bool get isPlaying => _isPlaying;
  bool get isRepeat => _isRepeat;
  Song get currSong => songs[index];

  AudioViewmodel(this.songs, this.index) {
    _audioPlayer = AudioPlayer();
    play();
    duration();
    notifyListeners();
  }

  void play() async {
    if (_isPlaying) {
      await _audioPlayer.pause();
    } else {
      await _audioPlayer.play(UrlSource(currSong.previewUrl));
    }
    _isPlaying = !_isPlaying;
    notifyListeners();
  }

  void playNext() async {
    if (index < songs.length - 1) {
      _isPlaying = true;
      index++;
      await _audioPlayer.play(UrlSource(currSong.previewUrl));
      notifyListeners();
    }
  }

  void playPrev() async {
    if (index > 0) {
      _isPlaying = true;
      index--;
      await _audioPlayer.play(UrlSource(currSong.previewUrl));
      notifyListeners();
    }
  }

  void toggleRepeat() {
    _isRepeat = !_isRepeat;
    notifyListeners();
  }

  Duration _currDuration = Duration.zero;
  Duration _playDuration = Duration.zero;

  Duration get currDuration => _currDuration;
  Duration get playDuration => _playDuration;

  void processDuration(Duration position) async {
    await _audioPlayer.seek(position);
  }

  void duration() {
    _audioPlayer.onPositionChanged.listen((newDuration) {
      _currDuration = newDuration;
      notifyListeners();
    });
    _audioPlayer.onDurationChanged.listen((newDuration) {
      _playDuration = newDuration;
      notifyListeners();
    });
    _audioPlayer.onPlayerComplete.listen((event) async {
      if (_isRepeat) {
        await _audioPlayer.play(UrlSource(currSong.previewUrl));
      } else {
        playNext();
      }
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}
