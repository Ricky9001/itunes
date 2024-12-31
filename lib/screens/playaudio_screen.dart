import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:itunes/models/song.dart';
import 'package:itunes/viewmodels/audio_viewmodel.dart';

class AudioPlayerScreen extends StatelessWidget {
  final List<Song> songs;
  final int index;
  AudioPlayerScreen({required this.songs, required this.index});

  // Format the time showing on the screen
  String formatTime(Duration duration) {
    String sec = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    String showTime = '${duration.inMinutes}:${sec}';
    return showTime;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AudioViewmodel(songs, index),
      child: Scaffold(
        appBar: AppBar(
          title: Consumer<AudioViewmodel>(
              builder: (context, viewModel, child) =>
                  Text(viewModel.currSong.collectionName)),
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
                Container(
                    decoration: BoxDecoration(
                        color: Colors.lightBlueAccent,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey,
                              blurRadius: 15,
                              offset: const Offset(4, 4)),
                          BoxShadow(
                              color: Colors.white,
                              blurRadius: 15,
                              offset: const Offset(-4, -4)),
                        ]),
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        Container(
                          width: double
                              .infinity, // Make the container take full width
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: FittedBox(
                              child: Image.network(
                                  viewModel.currSong.artworkUrl100),
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(14),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(viewModel.currSong.trackName,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20)),
                                  Text(viewModel.currSong.artistName),
                                ],
                              ))
                            ],
                          ),
                        ),
                      ],
                    )),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(formatTime(viewModel.currDuration)),
                    GestureDetector(
                      onTap: () {
                        viewModel.toggleRepeat();
                      },
                      child: viewModel.isRepeat
                          ? Icon(Icons.repeat_outlined, color: Colors.blue)
                          : Icon(Icons.repeat),
                    ),
                    Text(formatTime(viewModel.playDuration)),
                  ],
                ),
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                      thumbShape:
                          const RoundSliderThumbShape(enabledThumbRadius: 0)),
                  child: Slider(
                      min: 0,
                      max: viewModel.playDuration.inSeconds.toDouble(),
                      value: viewModel.currDuration.inSeconds.toDouble(),
                      activeColor: Colors.lightBlue,
                      onChanged: (double double) {},
                      onChangeEnd: (double double) {
                        viewModel
                            .processDuration(Duration(seconds: double.toInt()));
                      }),
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: ElevatedButton(
                        onPressed: viewModel.playPrev,
                        child: Icon(Icons.skip_previous),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                20.0), // Set your desired border radius
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 1, vertical: 20), // Button padding
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      flex: 2,
                      child: ElevatedButton(
                        onPressed: viewModel.play,
                        child: viewModel.isPlaying
                            ? Icon(Icons.pause)
                            : Icon(Icons.play_arrow),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                20.0), // Set your desired border radius
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 1, vertical: 20), // Button padding
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      flex: 1,
                      child: ElevatedButton(
                        onPressed: viewModel.playNext,
                        child: Icon(Icons.skip_next),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                20.0), // Set your desired border radius
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 1, vertical: 20), // Button padding
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}
