import 'dart:async';
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
  Timer? _timer;

  List<Song> get songs => _filterSongs;
  String get term => _term;
  String get sortOption => _sortOption;
  String get error => _error;
  SearchViewModel() {
    searchSongs();
  }

  void setTerm(String term) {
    _term = term;
    if (_timer?.isActive ?? false) _timer?.cancel();
    _timer = Timer(const Duration(milliseconds: 100), () {
      searchSongs();
    });
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
      _filterSongs.sort((a, b) {
        int sortCompare = a.collectionName
            .toLowerCase()
            .compareTo(b.collectionName.toLowerCase());
        if (sortCompare != 0) {
          return sortCompare;
        } else {
          return a.trackName.toLowerCase().compareTo(b.trackName.toLowerCase());
        }
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
