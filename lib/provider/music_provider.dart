import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:music_playlist_app/utils/data.dart';
import '../models/music.dart';

enum RepeatMode {
  off,
  all,
  one,
}

class MusicProvider extends ChangeNotifier {
  final AudioPlayer audioPlayer = AudioPlayer();
  MusicModel? currentSong;
  List<MusicModel> songs = [];
  bool isPlaying = false;
  bool isShuffleOn = false;
  RepeatMode repeatMode = RepeatMode.off;
  Duration position = Duration.zero;
  Duration duration = Duration.zero;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  MusicProvider() {
    _initAudioPlayer();
    loadSongs();
  }

  void _initAudioPlayer() {
    // State changes
    audioPlayer.onPlayerStateChanged.listen((state) {
      // ตรวจสอบสถานะการเล่นและอัพเดท isPlaying
      if (state == PlayerState.playing) {
        isPlaying = true;
      } else if (state == PlayerState.paused || state == PlayerState.stopped) {
        isPlaying = false;
      }
      notifyListeners();
    });

    // Duration changes
    audioPlayer.onDurationChanged.listen((newDuration) {
      duration = newDuration;
      notifyListeners();
    });

    // Position changes
    audioPlayer.onPositionChanged.listen((newPosition) {
      position = newPosition;
      notifyListeners();
    });

    // Handle completion
    audioPlayer.onPlayerComplete.listen((_) async {
      position = Duration.zero;
      isPlaying = false;
      notifyListeners();

      if (repeatMode == RepeatMode.one) {
        await _replayCurrentSong();
      } else if (repeatMode == RepeatMode.all) {
        await playNext();
      }
    });
  }

  Future<void> _replayCurrentSong() async {
    if (currentSong != null) {
      await audioPlayer.seek(Duration.zero);
      await audioPlayer.resume();
    }
  }

  Future<void> loadSongs() async {
    try {
      _isLoading = true;
      notifyListeners();

      // เคลียร์ข้อมูลเก่า
      songs.clear();

      await Future.delayed(const Duration(seconds: 1));
      final List<dynamic> tracks = mockSongsData['data'] as List;
      songs = tracks.map((track) => MusicModel.fromJson(track)).toList();

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      print('Error loading songs: $e');
      _isLoading = false;
      notifyListeners();
    }
  }

  // เพิ่มฟังก์ชันสำหรับ refresh แบบ manual
  Future<void> refreshSongs() async {
    try {
      // หยุดเพลงที่กำลังเล่น
      if (isPlaying) {
        await audioPlayer.pause();
        isPlaying = false;
      }

      // รีเซ็ตสถานะ
      currentSong = null;
      position = Duration.zero;
      duration = Duration.zero;

      // โหลดข้อมูลใหม่
      await loadSongs();
    } catch (e) {
      print('Error refreshing songs: $e');
    }
  }

  Future<void> playSong(MusicModel song) async {
    try {
      currentSong = song;
      position = Duration.zero;

      await audioPlayer.stop();
      await audioPlayer.setReleaseMode(
        repeatMode == RepeatMode.one ? ReleaseMode.loop : ReleaseMode.release,
      );

      // เปลี่ยนจาก setSourceUrl เป็น setSource และใช้ AssetSource
      await audioPlayer.setSource(AssetSource(song.preview));

      await audioPlayer.resume();
      isPlaying = true;
      notifyListeners();
    } catch (e) {
      print('Error playing song: $e');
      isPlaying = false;
      notifyListeners();
    }
  }

  Future<void> togglePlay() async {
    if (currentSong == null) return;

    try {
      if (isPlaying) {
        await audioPlayer.pause();
        isPlaying = false;
      } else {
        // ถ้าเพลงจบแล้ว ให้เริ่มเล่นใหม่
        if (position >= duration && duration.inSeconds > 0) {
          await audioPlayer.seek(Duration.zero);
        }
        await audioPlayer.resume();
        isPlaying = true;
      }
      notifyListeners();
    } catch (e) {
      print('Error toggling play: $e');
    }
  }

  Future<void> seekTo(Duration position) async {
    if (duration.inSeconds > 0 && position.inSeconds <= duration.inSeconds) {
      await audioPlayer.seek(position);
    }
  }

  Future<void> playNext() async {
    if (currentSong == null || songs.isEmpty) return;

    int currentIndex = songs.indexOf(currentSong!);
    int nextIndex;

    if (isShuffleOn) {
      nextIndex = _getRandomIndex(excluding: currentIndex);
    } else {
      nextIndex = (currentIndex + 1) % songs.length;
    }

    await playSong(songs[nextIndex]);
  }

  Future<void> playPrevious() async {
    if (currentSong == null || songs.isEmpty) return;

    int currentIndex = songs.indexOf(currentSong!);
    int previousIndex;

    if (isShuffleOn) {
      previousIndex = _getRandomIndex(excluding: currentIndex);
    } else {
      previousIndex = (currentIndex - 1 + songs.length) % songs.length;
    }

    await playSong(songs[previousIndex]);
  }

  void toggleShuffle() {
    isShuffleOn = !isShuffleOn;
    notifyListeners();
  }

  void toggleRepeat() {
    switch (repeatMode) {
      case RepeatMode.off:
        repeatMode = RepeatMode.all;
        audioPlayer.setReleaseMode(ReleaseMode.release);
        break;
      case RepeatMode.all:
        repeatMode = RepeatMode.one;
        audioPlayer.setReleaseMode(ReleaseMode.loop);
        break;
      case RepeatMode.one:
        repeatMode = RepeatMode.off;
        audioPlayer.setReleaseMode(ReleaseMode.release);
        break;
    }
    notifyListeners();
  }

  IconData getRepeatIcon() {
    switch (repeatMode) {
      case RepeatMode.off:
        return Icons.repeat;
      case RepeatMode.all:
        return Icons.repeat;
      case RepeatMode.one:
        return Icons.repeat_one;
    }
  }

  int _getRandomIndex({required int excluding}) {
    if (songs.length <= 1) return 0;

    int randomIndex;
    do {
      randomIndex = DateTime.now().millisecondsSinceEpoch % songs.length;
    } while (randomIndex == excluding);

    return randomIndex;
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }
}
