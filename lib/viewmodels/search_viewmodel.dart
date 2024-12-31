import 'dart:async';
import 'package:flutter/material.dart';
import 'package:itunes/models/song.dart';
import 'package:itunes/services/itune_service.dart';

// View model for managing the searching and sorting of songs
class SearchViewModel extends ChangeNotifier {
  final ITuneService _iTunesService = ITuneService();
  List<Song> _songs = [];
  List<Song> _filterSongs = [];
  List<Song> _pageSongs = [];
  String _term = '';
  String _sortOption = 'trackName';
  String _error = '';
  Timer? _timer;
  int _currPage = 1;
  int _pageSize = 10;
  int _totalNum = 0;

  List<Song> get songs => _pageSongs;
  String get term => _term;
  String get sortOption => _sortOption;
  String get error => _error;
  int get currPage => _currPage;
  int get pageSize => _pageSize;
  int get totalNum => _totalNum;

  SearchViewModel() {
    searchSongs();
  }

  // Manage the searching keyword
  void setTerm(String term) {
    _term = term;

    // handle event to the searching word when adding or deleting a letter
    if (_timer?.isActive ?? false) _timer?.cancel();
    _timer = Timer(const Duration(milliseconds: 100), () {
      searchSongs();
    });
    notifyListeners();
  }

  Future<void> searchSongs() async {
    try {
      final results = await _iTunesService.searchSongs();

      if (results.isEmpty) {
        _error = 'No song is found.';
      } else {
        _error = '';
        _songs = results.map((data) => Song.fromJson(data)).toList();
        filterSongs();
        pageSongs();
      }
      filterSongs();
      pageSongs();
    } catch (err) {
      _error = 'Cannot fetch songs';
    }
    notifyListeners();
  }

  // Manage the sorting option
  void setSortOption(String option) {
    _sortOption = option;
    sortSongs();
    pageSongs();
    notifyListeners();
  }

  // Manage filtering the song list by song and name and album name
  void filterSongs() {
    _filterSongs = _songs.where((song) {
      return song.trackName.toLowerCase().contains(_term.toLowerCase()) ||
          song.collectionName.toLowerCase().contains(_term.toLowerCase());
    }).toList();
    if (_filterSongs.isEmpty) {
      _error = 'No song is found. Please search another keywords';
    }
    _totalNum = _filterSongs.length;
    sortSongs();
    pageSongs();
    notifyListeners();
  }

  // Sort the song list by sort option and ascending order
  void sortSongs() {
    _currPage = 1;
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

  // Showing the song list by page
  void pageSongs() {
    final startIndex = (_currPage - 1) * _pageSize;
    final endIndex = startIndex + _pageSize;
    _pageSongs = _filterSongs.sublist(startIndex,
        endIndex > _filterSongs.length ? _filterSongs.length : endIndex);
    notifyListeners();
  }

  // handle next page function of the song list
  void nextPage() {
    if (_currPage * _pageSize < _filterSongs.length) {
      _currPage++;
      pageSongs();
      notifyListeners();
    }
  }

  // handle previous page function of the song list
  void prevPage() {
    if (_currPage > 1) {
      _currPage--;
      pageSongs();
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
