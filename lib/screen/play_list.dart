import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_playlist_app/models/playlist.dart';
import 'package:music_playlist_app/models/music.dart';
import 'package:provider/provider.dart';
import '../provider/playlist_provider.dart';
import '../provider/music_provider.dart';
import './tab.dart';

class PlayListScreen extends StatelessWidget {
  const PlayListScreen({super.key});

  void _navigateToPlayScreen(BuildContext context, MusicModel song) {
    Navigator.pushReplacement(
      context,
      CupertinoPageRoute(
        builder: (context) => TabScreen(
          currentTab: 1,
          song: song,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 20, right: 20, top: 40),
              child: Text(
                'My Playlists',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Consumer2<PlaylistProvider, MusicProvider>(
                builder: (context, playlistProvider, musicProvider, child) {
                  if (playlistProvider.playlists.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.queue_music,
                            size: 80,
                            color: Colors.white.withOpacity(0.3),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No playlists yet',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.5),
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: playlistProvider.playlists.length,
                    itemBuilder: (context, index) {
                      final playlist = playlistProvider.playlists[index];
                      final firstSong = playlist.songs.first;
                      final isPlaying =
                          musicProvider.currentSong?.id == firstSong.id &&
                              musicProvider.isPlaying;

                      return Dismissible(
                        key: Key(playlist.id),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 20.0),
                          color: Colors.red,
                          child: const Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ),
                        onDismissed: (direction) {
                          playlistProvider.removePlaylist(playlist.id);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Removed "${firstSong.title}"',
                                style: const TextStyle(color: Colors.white),
                              ),
                              backgroundColor: Colors.red,
                              behavior: SnackBarBehavior.floating,
                              margin: const EdgeInsets.all(16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          );
                        },
                        child: GestureDetector(
                          onTap: () => _navigateToPlayScreen(
                            context,
                            firstSong,
                          ),
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            child: Row(
                              children: [
                                // Album Cover with Playing Overlay
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                          image:
                                              AssetImage(firstSong.albumCover),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    if (isPlaying)
                                      Container(
                                        width: 60,
                                        height: 60,
                                        decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.5),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: const Icon(
                                          Icons.pause,
                                          color: Colors.white,
                                        ),
                                      ),
                                  ],
                                ),
                                Expanded(
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 15,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          firstSong.title,
                                          style: const TextStyle(
                                            color: Color(0xFFF2F2F2),
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          firstSong.artist,
                                          style: const TextStyle(
                                            color: Color(0xFF8E8E8E),
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                // More Options
                                IconButton(
                                  icon: const Icon(
                                    Icons.more_vert,
                                    color: Color(0xFF8E8E8E),
                                  ),
                                  onPressed: () {
                                    final playlistProvider =
                                        Provider.of<PlaylistProvider>(
                                      context,
                                      listen: false,
                                    );
                                    final bool isInPlaylist = playlistProvider
                                        .hasSongInAnyPlaylist(firstSong);

                                    showModalBottomSheet(
                                      context: context,
                                      backgroundColor: const Color(0xFF1E1E1E),
                                      builder: (context) => Container(
                                        padding: const EdgeInsets.all(16),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            ListTile(
                                              leading: Icon(
                                                isInPlaylist
                                                    ? Icons.playlist_remove
                                                    : Icons.playlist_add,
                                                color: Colors.white,
                                              ),
                                              title: Text(
                                                isInPlaylist
                                                    ? 'Remove from Playlist'
                                                    : 'Add to Playlist',
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                              onTap: () {
                                                Navigator.pop(context);
                                                if (isInPlaylist) {
                                                  // ลบเพลงจาก playlist
                                                  final playlistToRemove =
                                                      playlistProvider
                                                          .getPlaylistContainingSong(
                                                              firstSong);
                                                  if (playlistToRemove !=
                                                      null) {
                                                    playlistProvider
                                                        .removePlaylist(
                                                            playlistToRemove
                                                                .id);
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      SnackBar(
                                                        content: Text(
                                                          'Removed "${firstSong.title}" from playlist',
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                        ),
                                                        backgroundColor:
                                                            Colors.red,
                                                        behavior:
                                                            SnackBarBehavior
                                                                .floating,
                                                        margin: const EdgeInsets
                                                            .all(16),
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                      ),
                                                    );
                                                  }
                                                } else {
                                                  // เพิ่มเพลงใหม่ลง playlist
                                                  try {
                                                    playlistProvider
                                                        .createPlaylist(
                                                            PlaylistModel(
                                                      id: firstSong.id
                                                          .toString(),
                                                      name: firstSong.title,
                                                      songs: [firstSong],
                                                      coverUrl:
                                                          firstSong.albumCover,
                                                    ));
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      SnackBar(
                                                        content: Text(
                                                          'Added "${firstSong.title}" to playlist',
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                        ),
                                                        backgroundColor:
                                                            const Color(
                                                                0xFF6156E2),
                                                        behavior:
                                                            SnackBarBehavior
                                                                .floating,
                                                        margin: const EdgeInsets
                                                            .all(16),
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                      ),
                                                    );
                                                  } catch (e) {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      SnackBar(
                                                        content: Text(
                                                          e.toString(),
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                        ),
                                                        backgroundColor:
                                                            Colors.red,
                                                        behavior:
                                                            SnackBarBehavior
                                                                .floating,
                                                        margin: const EdgeInsets
                                                            .all(16),
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                      ),
                                                    );
                                                  }
                                                }
                                              },
                                            ),
                                            const ListTile(
                                              leading: Icon(
                                                Icons.share,
                                                color: Colors.white,
                                              ),
                                              title: Text(
                                                'Share',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                              // onTap: () {
                                              //   Navigator.pop(context);
                                              // },
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                )
                                // Play/Pause Button
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
