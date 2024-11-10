class SongModel {
  final int id;
  final String title;
  final String artist;
  final String albumCover;
  final String previewUrl;

  SongModel({
    required this.id,
    required this.title,
    required this.artist,
    required this.albumCover,
    required this.previewUrl,
  });

  factory SongModel.fromJson(Map<String, dynamic> json) {
    return SongModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? 'Unknown',
      artist: json['artist']['name'] ?? 'Unknown Artist',
      albumCover: json['album']['cover_medium'] ?? '',
      previewUrl: json['preview'] ?? '',
    );
  }
}
