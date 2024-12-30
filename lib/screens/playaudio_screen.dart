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
                              child: Image.network(song.artworkUrl100),
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
                                  Text(song.trackName,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20)),
                                  Text(song.artistName),
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
                    Text('0:00'),
                    GestureDetector(onTap: () {}, child: Icon(Icons.repeat)),
                    Text('0:00'),
                  ],
                ),
                Slider(
                  min: 0,
                  max: 100,
                  value: 50,
                  activeColor: Colors.lightBlue,
                  onChanged: (double double) {},
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: ElevatedButton(
                        onPressed: () {},
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
                        onPressed: () {},
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
