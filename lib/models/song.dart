class Song {
  final String trackName;
  final String collectionName;
  final String artworkUrl100;

  Song({
    required this.trackName,
    required this.collectionName,
    required this.artworkUrl100,
  });

  factory Song.fromJson(Map<String, dynamic> json) {
    return Song(
      trackName: json['trackName'],
      collectionName: json['collectionName'],
      artworkUrl100: json['artworkUrl100'],
    );
  }
}
