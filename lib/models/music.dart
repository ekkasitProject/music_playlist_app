class MusicModel {
  final int id;
  final String title;
  final String artist;
  final String albumCover;
  final String preview;

  MusicModel({
    required this.id,
    required this.title,
    required this.artist,
    required this.albumCover,
    required this.preview,
  });

  factory MusicModel.fromJson(Map<String, dynamic> json) {
    // กำหนดค่าเริ่มต้นสำหรับ albumCover
    String defaultCover = 'assets/images/cover_medium.jpg';

    // ตรวจสอบว่ามี album cover หรือไม่
    String cover = json['album']?['cover_medium'] ?? defaultCover;

    return MusicModel(
      id: json['id'],
      title: json['title'],
      artist: json['artist']['name'],
      albumCover: cover,
      preview: json['preview'],
    );
  }
}
