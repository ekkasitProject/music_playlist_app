import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_playlist_app/models/playlist.dart';
import 'package:music_playlist_app/provider/playlist_provider.dart';
import 'package:music_playlist_app/screen/tab.dart';
import 'package:provider/provider.dart';
import '../provider/music_provider.dart';
import '../models/music.dart';

class PlayScreen extends StatelessWidget {
  final MusicModel? song;
  const PlayScreen({super.key, this.song});

  @override
  Widget build(BuildContext context) {
    return Consumer<MusicProvider>(
      builder: (context, provider, child) {
        final currentSong = provider.currentSong;
        // แสดงหน้าว่างถ้ายังไม่มีเพลงที่เล่น
        if (currentSong == null) {
          return Scaffold(
            backgroundColor: Colors.black,
            body: SafeArea(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => const TabScreen(
                                  currentTab: 0,
                                ),
                              ),
                            );
                          },
                          child: Image.asset(
                            'assets/images/arrow_left.png',
                            width: 30,
                          ),
                        ),
                        const Text(
                          'Now Playing',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        // Placeholder สำหรับปุ่ม add playlist
                        const SizedBox(width: 30),
                      ],
                    ),

                    // Empty State Content
                    Expanded(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 200,
                              height: 200,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.05),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Icon(
                                Icons.music_note,
                                size: 80,
                                color: Colors.white.withOpacity(0.2),
                              ),
                            ),
                            const SizedBox(height: 32),
                            Text(
                              'No song playing',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.5),
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Choose a song from the list',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.3),
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Controls placeholder
                    Container(
                      height: 150,
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(Icons.shuffle,
                              color: Colors.grey.withOpacity(0.3), size: 24),
                          Icon(Icons.skip_previous_outlined,
                              color: Colors.grey.withOpacity(0.3), size: 40),
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: [
                                  const Color(0xFF6156E2).withOpacity(0.3),
                                  const Color(0xFF4C9BF7).withOpacity(0.3),
                                ],
                              ),
                            ),
                            child: Icon(Icons.play_arrow,
                                color: Colors.white.withOpacity(0.3), size: 32),
                          ),
                          Icon(Icons.skip_next,
                              color: Colors.grey.withOpacity(0.3), size: 40),
                          Icon(Icons.repeat,
                              color: Colors.grey.withOpacity(0.3), size: 24),
                        ],
                      ),
                    ),
                    const SizedBox(height: 70),
                  ],
                ),
              ),
            ),
          );
        }

        final position = provider.position;
        final duration = provider.duration;

        final double sliderValue = duration.inSeconds > 0
            ? position.inSeconds
                .toDouble()
                .clamp(0, duration.inSeconds.toDouble())
            : 0.0;

        final playlistProvider = Provider.of<PlaylistProvider>(context);
        final bool isInPlaylist =
            playlistProvider.hasSongInAnyPlaylist(currentSong);
        return Scaffold(
          backgroundColor: Colors.black,
          body: SafeArea(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  // Header
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => const TabScreen(
                                currentTab: 0,
                              ),
                            ),
                          );
                        },
                        child: Image.asset(
                          'assets/images/arrow_left.png',
                          width: 30,
                        ),
                      ),
                      const Text(
                        'Now Playing',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => _handlePlaylistAction(
                          context,
                          currentSong,
                          isInPlaylist,
                          playlistProvider,
                        ),
                        child: AnimatedCrossFade(
                          duration: const Duration(milliseconds: 300),
                          reverseDuration: const Duration(milliseconds: 300),
                          crossFadeState: isInPlaylist
                              ? CrossFadeState.showSecond
                              : CrossFadeState.showFirst,
                          firstChild: Image.asset(
                            'assets/images/add_playlist.png',
                            width: 30,
                          ),
                          secondChild: Image.asset(
                            'assets/images/remove_playlist.png',
                            width: 30,
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Album Cover
                  Container(
                    width: 220,
                    height: 220,
                    margin: const EdgeInsets.symmetric(
                      vertical: 32,
                      horizontal: 24,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.withOpacity(0.3),
                          blurRadius: 30,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Image.asset(
                        currentSong.albumCover,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  // Song Info and Controls section
                  Expanded(
                    flex: 4,
                    child: Column(
                      children: [
                        const SizedBox(height: 24),
                        Text(
                          currentSong.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          currentSong.artist,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 24),

                        // Progress Bar
                        Column(
                          children: [
                            SliderTheme(
                              data: SliderTheme.of(context).copyWith(
                                activeTrackColor: const Color(0xFF6156E2),
                                inactiveTrackColor: const Color(0xFFF2F2F2),
                                thumbColor: const Color(0xFF6156E2),
                                trackHeight: 4.0,
                                thumbShape: const RoundSliderThumbShape(
                                  enabledThumbRadius: 6.0,
                                ),
                                overlayShape: const RoundSliderOverlayShape(
                                  overlayRadius: 14.0,
                                ),
                              ),
                              child: Slider(
                                value: sliderValue,
                                max: duration.inSeconds.toDouble(),
                                onChanged: (value) {
                                  if (duration.inSeconds > 0) {
                                    provider.seekTo(
                                      Duration(seconds: value.toInt()),
                                    );
                                  }
                                },
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 24),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    provider.formatDuration(position),
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    provider.formatDuration(duration),
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        // Controls
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.shuffle,
                                  color: provider.isShuffleOn
                                      ? Color(0xFF6156E2)
                                      : Colors.grey,
                                  size: 24,
                                ),
                                onPressed: provider.toggleShuffle,
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.skip_previous_outlined,
                                  color: Colors.white,
                                  size: 40,
                                ),
                                onPressed: provider.playPrevious,
                              ),
                              Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFF6156E2),
                                      Color(0xFF4C9BF7),
                                    ],
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.blue.withOpacity(0.3),
                                      blurRadius: 15,
                                      offset: const Offset(0, 5),
                                    ),
                                  ],
                                ),
                                child: IconButton(
                                  icon: Icon(
                                    provider.isPlaying
                                        ? Icons.pause
                                        : Icons.play_arrow,
                                    color: Colors.white,
                                    size: 32,
                                  ),
                                  onPressed: provider.togglePlay,
                                ),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.skip_next,
                                  color: Colors.white,
                                  size: 40,
                                ),
                                onPressed: provider.playNext,
                              ),
                              IconButton(
                                icon: Icon(
                                  provider.getRepeatIcon(),
                                  color: provider.repeatMode != RepeatMode.off
                                      ? Colors.blue
                                      : Colors.grey,
                                  size: 24,
                                ),
                                onPressed: provider.toggleRepeat,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 70),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

void _handlePlaylistAction(BuildContext context, MusicModel currentSong,
    bool isInPlaylist, PlaylistProvider provider) {
  if (currentSong != null) {
    if (isInPlaylist) {
      // ลบเพลงออกจาก playlist
      final playlistToRemove = provider.getPlaylistContainingSong(currentSong);
      if (playlistToRemove != null) {
        provider.removePlaylist(playlistToRemove.id);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Removed "${currentSong.title}" from playlist',
              style: const TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.all(16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            duration: const Duration(seconds: 1),
          ),
        );
      }
    } else {
      // เพิ่มเพลงลง playlist
      try {
        final playlist = PlaylistModel(
          id: DateTime.now().toString(),
          name: currentSong.title,
          songs: [currentSong],
          coverUrl: currentSong.albumCover,
        );
        provider.createPlaylist(playlist);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Added "${currentSong.title}" to playlist',
              style: const TextStyle(color: Colors.white),
            ),
            backgroundColor: const Color(0xFF6156E2),
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.all(16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            duration: const Duration(seconds: 1),
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              e.toString(),
              style: const TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.all(16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            duration: const Duration(seconds: 1),
          ),
        );
      }
    }
  }
}
