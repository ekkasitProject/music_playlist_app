import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_playlist_app/models/playlist.dart';
import 'package:music_playlist_app/provider/playlist_provider.dart';
import 'package:music_playlist_app/provider/music_provider.dart';
import 'package:music_playlist_app/screen/tab.dart';
import 'package:music_playlist_app/widgets/shimmer.dart';
import 'package:provider/provider.dart';
import '../models/music.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool isSearchExpanded = false;
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    // Load songs when screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MusicProvider>().loadSongs();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleSearch() {
    setState(() {
      isSearchExpanded = !isSearchExpanded;
      if (isSearchExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
        searchQuery = '';
      }
    });
  }

  void _navigateToPlayTab(BuildContext context, MusicModel song) {
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
      backgroundColor: const Color.fromRGBO(0, 0, 0, 1),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Section
              SizedBox(
                width: 220,
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/profile.png',
                      width: 70,
                      height: 70,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Sarwar Jahan',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFF2F2F2),
                            ),
                          ),
                          Text(
                            'Gold Member',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                              color: Color(0xFFDEDEDE),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),

              // Search Section
              Container(
                margin: const EdgeInsets.only(top: 20),
                width: double.infinity,
                height: 100,
                child: Row(
                  children: [
                    SizedBox(
                      width: isSearchExpanded ? 0 : 200,
                      child: const Text(
                        'Listen The Latest Musics',
                        style: TextStyle(
                          color: Color(0xFFF2F2F2),
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.clip,
                      ),
                    ),
                    Expanded(
                      child: AnimatedBuilder(
                        animation: _animation,
                        builder: (context, child) {
                          return GestureDetector(
                            onTap: _toggleSearch,
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: isSearchExpanded
                                  ? Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0,
                                      ),
                                      child: Center(
                                        child: TextField(
                                          style: const TextStyle(
                                            color: Colors.white,
                                          ),
                                          onChanged: (value) {
                                            setState(() {
                                              searchQuery = value;
                                            });
                                          },
                                          decoration: InputDecoration(
                                            hintText: 'Search for music...',
                                            hintStyle: const TextStyle(
                                              color: Colors.white70,
                                            ),
                                            border: InputBorder.none,
                                            suffixIcon: IconButton(
                                              icon: const Icon(
                                                Icons.close,
                                                color: Colors.white,
                                              ),
                                              onPressed: _toggleSearch,
                                            ),
                                          ),
                                          autofocus: true,
                                        ),
                                      ),
                                    )
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          'assets/images/search.png',
                                          width: 18,
                                          height: 18,
                                        ),
                                        const SizedBox(width: 8),
                                        const Text(
                                          'Search Music',
                                          style: TextStyle(
                                            color: Color(0xFF8E8E8E),
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),

              // Recommended Section
              Container(
                margin: const EdgeInsets.only(top: 10, bottom: 10),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Recommend for you',
                      style: TextStyle(
                        color: Color(0xFFF2F2F2),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              // Songs List
              Expanded(
                child: Consumer<MusicProvider>(
                  builder: (context, provider, child) {
                    if (provider.songs.isEmpty) {
                      return const Center(
                        child: ShimmerLoading(),
                      );
                    }

                    final filteredSongs = provider.songs.where((song) {
                      final query = searchQuery.toLowerCase();
                      return searchQuery.isEmpty ||
                          song.title.toLowerCase().contains(query) ||
                          song.artist.toLowerCase().contains(query);
                    }).toList();

                    return RefreshIndicator(
                      color: const Color(0xFF6156E2),
                      backgroundColor: Colors.black,
                      onRefresh: () async {
                        await provider.loadSongs();
                      },
                      child: ListView.builder(
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemCount: filteredSongs.length,
                        itemBuilder: (context, index) {
                          final song = filteredSongs[index];
                          final isPlaying =
                              provider.currentSong?.id == song.id &&
                                  provider.isPlaying;

                          return GestureDetector(
                            onTap: () {
                              provider.playSong(song);
                              _navigateToPlayTab(context, song);
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              child: Row(
                                children: [
                                  // Album Cover
                                  Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.asset(
                                          song.albumCover,
                                          width: 60,
                                          height: 60,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      if (isPlaying)
                                        Container(
                                          width: 60,
                                          height: 60,
                                          decoration: BoxDecoration(
                                            color:
                                                Colors.black.withOpacity(0.5),
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
                                            song.title,
                                            style: const TextStyle(
                                              color: Color(0xFFF2F2F2),
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            song.artist,
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
                                          .hasSongInAnyPlaylist(song);

                                      showModalBottomSheet(
                                        context: context,
                                        backgroundColor:
                                            const Color(0xFF1E1E1E),
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
                                                                song);
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
                                                            'Removed "${song.title}"',
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
                                                          margin:
                                                              const EdgeInsets
                                                                  .all(16),
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
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
                                                        id: song.id.toString(),
                                                        name: song.title,
                                                        songs: [song],
                                                        coverUrl:
                                                            song.albumCover,
                                                      ));
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        SnackBar(
                                                          content: Text(
                                                            'Added "${song.title}" to playlist',
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
                                                          margin:
                                                              const EdgeInsets
                                                                  .all(16),
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
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
                                                          margin:
                                                              const EdgeInsets
                                                                  .all(16),
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
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
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }
}
