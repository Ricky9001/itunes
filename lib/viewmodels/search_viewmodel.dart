import 'package:flutter/material.dart';
import 'package:itunes/models/song.dart';
import 'package:itunes/services/itune_service.dart';

class SearchViewModel extends ChangeNotifier {
  final ITuneService _iTunesService = ITuneService();
  List<Song> _songs = [];
  List<Song> _filterSongs = [];
  String _term = '';
  String _sortOption = 'trackName';
  String _error = '';

  List<Song> get songs => _filterSongs;
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
      filterSongs();
    } catch (err) {
      _error = 'Cannot fetch songs';
    }
    notifyListeners();
  }

  void setSortOption(String option) {
    _sortOption = option;
    sortSongs();
    notifyListeners();
  }

  void filterSongs() {
    _filterSongs = _songs.where((song) {
      return song.trackName.toLowerCase().contains(_term.toLowerCase()) ||
          song.collectionName.toLowerCase().contains(_term.toLowerCase());
    }).toList();
    sortSongs();
    notifyListeners();
  }

  void sortSongs() {
    if (_sortOption == 'trackName') {
      _filterSongs.sort((a, b) =>
          a.trackName.toLowerCase().compareTo(b.trackName.toLowerCase()));
    } else {
      _filterSongs.sort((a, b) => a.collectionName
          .toLowerCase()
          .compareTo(b.collectionName.toLowerCase()));
    }
  }
}
