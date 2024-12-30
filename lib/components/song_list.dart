import 'package:flutter/material.dart';
import 'package:itunes/models/song.dart';

class SongList extends StatelessWidget {
  final List<Song> songs;

  SongList({required this.songs});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: songs.length,
        itemBuilder: (context, index) {
          final song = songs[index];
          return ListTile(
            leading: Image.network(song.artworkUrl100),
            title: Text(song.trackName),
            subtitle: Text(song.collectionName),
          );
        });
  }
}
