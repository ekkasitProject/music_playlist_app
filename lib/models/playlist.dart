import 'package:music_playlist_app/models/song.dart';

class PlaylistModel {
  final String id;
  final String name;
  final List<SongModel> songs;
  final String? coverUrl;

  PlaylistModel({
    required this.id,
    required this.name,
    required this.songs,
    this.coverUrl,
  });
}
