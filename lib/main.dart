import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:music_playlist_app/provider/playlist_provider.dart';
import 'package:music_playlist_app/provider/music_provider.dart';
import 'package:music_playlist_app/screen/tab.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // ตั้งค่าให้แสดงแนวตั้งเท่านั้น
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // กำหนดสีของ System UI เมื่อมีการแสดงผล
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarColor: Colors.transparent, // เปลี่ยนเป็น transparent
    systemNavigationBarIconBrightness: Brightness.light,
    systemNavigationBarDividerColor: Colors.transparent,
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
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        fontFamily: 'Nunito',
        scaffoldBackgroundColor: Colors.black, // เพิ่มสีพื้นหลัง
        useMaterial3: true, // ใช้ Material 3
        brightness: Brightness.dark, // กำหนดโหมดมืด
      ),
      home: const TabScreen(),
    );
  }
}
