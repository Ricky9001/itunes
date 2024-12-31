// Model representing a song
class Song {
  final String artistName;
  final String trackName;
  final String collectionName;
  final String artworkUrl100;
  final String previewUrl;

  Song({
    required this.artistName,
    required this.trackName,
    required this.collectionName,
    required this.artworkUrl100,
    required this.previewUrl,
  });

  factory Song.fromJson(Map<String, dynamic> json) {
    return Song(
      artistName: json['artistName'],
      trackName: json['trackName'],
      collectionName: json['collectionName'],
      artworkUrl100: json['artworkUrl100'],
      previewUrl: json['previewUrl'],
    );
  }
}
