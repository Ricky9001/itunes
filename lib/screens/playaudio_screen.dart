import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:itunes/models/song.dart';
import 'package:itunes/viewmodels/audio_viewmodel.dart';

class AudioPlayerScreen extends StatelessWidget {
  final Song song;
  AudioPlayerScreen({required this.song});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AudioViewmodel(song),
      child: Scaffold(
        appBar: AppBar(
          title: Text(song.collectionName),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back)),
        ),
        body: Consumer<AudioViewmodel>(builder: (context, viewModel, child) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.network(song.artworkUrl100),
                ),
                Text(song.trackName),
                Text(song.artistName),
                ElevatedButton(
                    onPressed: viewModel.play,
                    child: viewModel.isPlaying
                        ? Icon(Icons.pause)
                        : Icon(Icons.play_arrow))
              ],
            ),
          );
        }),
      ),
    );
  }
}
