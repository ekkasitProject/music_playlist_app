import 'package:flutter/cupertino.dart';
import 'package:music_playlist_app/models/playlist.dart';
import 'package:music_playlist_app/models/music.dart';

class PlaylistProvider extends ChangeNotifier {
  List<PlaylistModel> playlists = [];

  bool hasPlaylistWithId(String id) {
    return playlists.any((playlist) => playlist.id == id);
  }

  bool hasSongInAnyPlaylist(MusicModel song) {
    return playlists
        .any((playlist) => playlist.songs.any((s) => s.id == song.id));
  }

  PlaylistModel? getPlaylistContainingSong(MusicModel song) {
    try {
      return playlists.firstWhere(
        (playlist) => playlist.songs.any((s) => s.id == song.id),
      );
    } catch (e) {
      return null;
    }
  }

  void createPlaylist(PlaylistModel playlist) {
    if (hasPlaylistWithId(playlist.id)) {
      throw Exception('This song is already in a playlist');
    }
    playlists.add(playlist);
    notifyListeners();
  }

  void addSongToPlaylist(PlaylistModel playlist, MusicModel song) {
    final index = playlists.indexWhere((p) => p.id == playlist.id);
    if (index == -1) return;

    if (hasSongInAnyPlaylist(song)) {
      throw Exception('This song is already in a playlist');
    }

    final updatedPlaylist = PlaylistModel(
      id: playlist.id,
      name: playlist.name,
      songs: [...playlist.songs, song],
    );
    playlists[index] = updatedPlaylist;
    notifyListeners();
  }

  void removePlaylist(String id) {
    playlists.removeWhere((playlist) => playlist.id == id);
    notifyListeners();
  }
}
