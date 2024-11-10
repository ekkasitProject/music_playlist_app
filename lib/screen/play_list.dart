import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_playlist_app/models/song.dart';
import 'package:provider/provider.dart';
import '../provider/playlist_provider.dart';
import '../provider/song_provider.dart';
import './tab.dart';

class PlayListScreen extends StatelessWidget {
  const PlayListScreen({super.key});

  void _navigateToPlayScreen(BuildContext context, SongModel song) {
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
      backgroundColor: const Color(0xFF0A071E),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
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

            // Playlists
            Expanded(
              child: Consumer<PlaylistProvider>(
                builder: (context, playlistProvider, child) {
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
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: playlist.coverUrl != null
                              ? NetworkImage(playlist.coverUrl!)
                              : null,
                          backgroundColor: Colors.grey[300],
                        ),
                        title: Text(
                          playlist.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        subtitle: Text(
                          '${playlist.name} songs',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.6),
                            fontSize: 14,
                          ),
                        ),
                        onTap: () {
                          // Navigate to playlist details screen
                          // You can implement the navigation logic here
                        },
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
