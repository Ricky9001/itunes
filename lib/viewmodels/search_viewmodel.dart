import 'package:flutter/material.dart';
import 'package:itunes/models/song.dart';
import 'package:itunes/services/itune_service.dart';

class SearchViewModel extends ChangeNotifier {
  final ITuneService _iTunesService = ITuneService();
  List<Song> _songs = [];
  String _term = '';
  String _sortOption = 'trackName';
  String _error = '';

  List<Song> get songs => _songs;
  String get term => _term;
  String get sortOption => _sortOption;
  String get error => _error;

  void setTerm(String term) {
    _term = term;
    notifyListeners();
  }

  Future<void> searchSongs() async {
    try {
      final results = await _iTunesService.searchSongs();
      _songs = results.map((data) => Song.fromJson(data)).toList();
      _sortSongs();
    } catch (err) {
      _error = 'Cannot fetch songs';
    }
    notifyListeners();
  }

  void setSortOption(String option) {
    _sortOption = option;
    _sortSongs();
    notifyListeners();
  }

  void _sortSongs() {
    if (_sortOption == 'trackName') {
      _songs.sort((a, b) => a.trackName.compareTo(b.trackName));
    } else {
      _songs.sort((a, b) => a.collectionName.compareTo(b.collectionName));
    }
  }
}
