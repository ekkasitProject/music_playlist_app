import 'package:flutter/material.dart';
import 'package:music_playlist_app/models/music.dart';
import 'package:music_playlist_app/screen/home.dart';
import 'package:music_playlist_app/screen/play.dart';
import 'package:music_playlist_app/screen/play_list.dart';

class TabScreen extends StatefulWidget {
  final int? currentTab;
  final MusicModel? song;

  const TabScreen({
    super.key,
    this.currentTab,
    this.song,
  });

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.currentTab ?? 0;
  }

  List<Widget> get _pages => [
        const HomeScreen(),
        PlayScreen(song: widget.song),
        const PlayListScreen(),
      ];

  final List<String> _navIcons = ['home', 'play', 'heart'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _pages[_selectedIndex],
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(95, 46, 40, 62),
                    spreadRadius: 7,
                    blurRadius: 12,
                  ),
                ],
              ),
              height: 85,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(_navIcons.length, (index) {
                  return _buildNavItem(index, _navIcons[index]);
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, String iconName) {
    bool isSelected = _selectedIndex == index;
    String assetPath =
        'assets/images/${iconName}${isSelected ? '_active' : ''}.png';

    return GestureDetector(
      onTap: () => setState(() => _selectedIndex = index),
      child: Image.asset(
        assetPath,
        width: 21,
        height: 24,
      ),
    );
  }
}
