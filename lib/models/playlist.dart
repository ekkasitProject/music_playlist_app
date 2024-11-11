import 'package:music_playlist_app/models/music.dart';

class PlaylistModel {
  final String id;
  final String name;
  final List<MusicModel> songs;
  final String? coverUrl;

  PlaylistModel({
    required this.id,
    required this.name,
    required this.songs,
    this.coverUrl,
  });
}
