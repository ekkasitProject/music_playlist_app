import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:music_playlist_app/provider/playlist_provider.dart';
import 'package:music_playlist_app/provider/song_provider.dart';
import 'package:music_playlist_app/screen/tab.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // ตั้งค่าให้แสดงแนวตั้งเท่านั้น
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // กำหนดสีของ System UI ให้เป็นโหมดมืด
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // สีพื้นหลัง status bar
    statusBarIconBrightness: Brightness.light, // สีไอคอน status bar
    systemNavigationBarColor: Colors.black, // สีพื้นหลัง navigation bar
    systemNavigationBarIconBrightness:
        Brightness.light, // สีไอคอน navigation bar
  ));

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MusicProvider()),
        ChangeNotifierProvider(create: (_) => PlaylistProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Music Playlist App',
      themeMode: ThemeMode.dark, // กำหนดโหมดธีมเป็น dark
      theme: ThemeData(
        fontFamily: 'Nunito',
      ),
      home: const TabScreen(),
    );
  }
}
