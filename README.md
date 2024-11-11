# Music Player Application

แอพพลิเคชันเครื่องเล่นเพลงที่พัฒนาด้วย Flutter พร้อมฟีเจอร์การจัดการเพลย์ลิสต์และการควบคุมการเล่นเพลงที่หลากหลาย

## โครงสร้างโปรเจค

```
lib/
├── models/
│   ├── music.dart          # โมเดลข้อมูลเพลง
│   └── playlist.dart      # โมเดลข้อมูลเพลย์ลิสต์
│
├── provider/
│   ├── music_provider.dart    # จัดการการเล่นเพลงและสถานะ
│   └── playlist_provider.dart # จัดการเพลย์ลิสต์
│
├── screens/
│   ├── home.dart          # หน้าหลักแสดงรายการเพลง
│   ├── play.dart          # หน้าเล่นเพลง
│   ├── playlist.dart      # หน้าเพลย์ลิสต์
│   └── tab.dart           # จัดการ Navigation
│
├── utils/
│   └── data.dart          # ข้อมูล Mock สำหรับเพลง
│
└── widgets/
    └── shimmer.dart       # Loading Effect
```

## การทำงานของระบบ

### 1. State Management
- ใช้ Provider Pattern ในการจัดการสถานะของแอพ
- แบ่งเป็น 2 Provider หลัก:
  - `MusicProvider`: จัดการการเล่นเพลง
  - `PlaylistProvider`: จัดการเพลย์ลิสต์

### 2. การเล่นเพลง (MusicProvider)
```dart
Flow การเล่นเพลง:
1. โหลดข้อมูลเพลง (loadSongs)
2. เลือกเพลงที่จะเล่น (playSong)
3. ควบคุมการเล่น:
   - เล่น/หยุด (togglePlay)
   - เพลงถัดไป (playNext)
   - เพลงก่อนหน้า (playPrevious)
   - สุ่มเพลง (toggleShuffle)
   - เล่นซ้ำ (toggleRepeat)
```

### 3. การจัดการเพลย์ลิสต์ (PlaylistProvider)
```dart
การจัดการเพลย์ลิสต์:
1. สร้างเพลย์ลิสต์ใหม่ (createPlaylist)
2. ลบเพลย์ลิสต์ (removePlaylist)
3. ตรวจสอบเพลงในเพลย์ลิสต์ (hasSongInAnyPlaylist)
4. ค้นหาเพลย์ลิสต์ที่มีเพลง (getPlaylistContainingSong)
```

### 4. หน้าจอหลัก (HomeScreen)
```dart
ฟีเจอร์:
1. แสดงรายการเพลง
2. ค้นหาเพลง
3. เพิ่ม/ลบเพลงจากเพลย์ลิสต์
4. Refresh เพลง
5. Loading Effect ด้วย Shimmer
```

### 5. หน้าเล่นเพลง (PlayScreen)
```dart
ฟีเจอร์:
1. แสดงข้อมูลเพลงปัจจุบัน
2. ควบคุมการเล่น:
   - Play/Pause
   - Next/Previous
   - Shuffle
   - Repeat
3. Progress Bar
4. เพิ่ม/ลบจากเพลย์ลิสต์
```

### 6. ระบบนำทาง (Navigation)
```dart
TabScreen:
- Home Tab: รายการเพลง
- Play Tab: เล่นเพลง
- Playlist Tab: จัดการเพลย์ลิสต์
```

## การจัดการ Assets
```yaml
assets:
├── images/  # ไฟล์รูปภาพ
└── sounds/  # ไฟล์เพลง MP3
```

## การติดตั้งและรัน

1. ติดตั้ง Dependencies:
```bash
flutter pub get
```

2. รันแอพ:
```bash
flutter run
```

## Dependencies ที่ใช้

```yaml
dependencies:
  flutter:
    sdk: flutter
  provider: ^6.0.0        # State Management
  audioplayers: ^5.2.1    # เล่นไฟล์เสียง
```

## Future Improvements

1. เพิ่มระบบ Authentication
2. เพิ่มการแชร์เพลย์ลิสต์
3. เพิ่มการดาวน์โหลดเพลง
4. เพิ่มการแสดงเนื้อเพลง






