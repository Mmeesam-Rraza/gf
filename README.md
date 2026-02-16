# EV - Student Management App

Complete offline Android student management application built with Flutter.

## ✨ Features

- **12 Fixed Classes**: FE-1 to FE-4, SE-1 to SE-4, DE-1 to DE-4
- **Roll Number Management**: 50 fixed + 5 custom roll numbers per class
- **Student Profiles** with:
  - Student & Father contact numbers
  - Photo capture (Camera & Gallery)
  - 5-color behavior tags
  - Complete student information
- **Contact Actions**: Call, SMS, WhatsApp with auto-filled messages
- **Multi-language**: English, Urdu, Roman Urdu
- **Dark/Light Mode**
- **PIN/Password Lock**
- **Export**: JSON, PDF formats
- **Fully Offline**: SQLite database

## 🔧 Fixed Issues from Previous Version

###  1. Android Resource Structure ✅
- Added `android/app/src/main/res/values/styles.xml` (correct name with 's')
- Added `android/app/src/main/res/drawable/launch_background.xml`
- Proper mipmap icon structure

### 2. Camera & Gallery Integration ✅
- Added `image_picker` package
- Implemented camera capture
- Implemented gallery selection
- Image storage in app directory

### 3. Dual Contact Fields ✅
- Student contact field
- Father contact field
- Separate call/SMS/WhatsApp for each

### 4. Database Schema Updates ✅
- Added `imagePath` column
- Added `fatherContact` column
- Database migration for existing data

### 5. Permissions & Queries ✅
- Camera permission
- Storage permissions (READ_MEDIA_IMAGES for Android 13+)
- WhatsApp, Call, SMS queries for Android 11+

### 6. GitHub Actions Workflow ✅
- Complete CI/CD setup
- Automatic APK build on push
- APK upload as artifact with `actions/upload-artifact@v4`
- 90-day retention

### 7. Removed Unnecessary Files ✅
- Removed `assets/previews/` directory (SVG preview files)
- Cleaned up unnecessary preview HTML files

## 📦 Setup Instructions

### Prerequisites
- Flutter SDK 3.24.0 or higher
- Android Studio or VS Code
- Java JDK 17

### Installation

1. **Clone the repository**
   ```bash
   git clone <your-repo-url>
   cd ev_app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate launcher icons**
   - Place your `app_icon.png` (1024x1024) in `assets/icon/`
   - Run:
     ```bash
     flutter pub run flutter_launcher_icons
     ```

4. **Run the app**
   ```bash
   flutter run
   ```

## 🏗️ Build APK

### Local Build

```bash
# Build release APK
flutter build apk --release

# APK location
# build/app/outputs/flutter-apk/app-release.apk
```

### GitHub Actions Build

1. Push to `main` or `master` branch
2. GitHub Actions will automatically:
   - Build the APK
   - Upload as artifact
3. Download APK from Actions tab → Build workflow → Artifacts

## 📱 App Structure

```
ev_app/
├── android/              # Android-specific configuration
│   ├── app/
│   │   ├── build.gradle  # App-level Gradle config
│   │   └── src/main/
│   │       ├── AndroidManifest.xml  # Permissions & queries
│   │       ├── kotlin/              # MainActivity
│   │       └── res/
│   │           ├── values/
│   │           │   └── styles.xml   # Theme styles
│   │           ├── drawable/
│   │           │   └── launch_background.xml
│   │           └── mipmap-*/        # App icons
│   ├── build.gradle      # Project-level Gradle
│   └── settings.gradle   # Gradle settings
│
├── lib/
│   ├── main.dart         # App entry point
│   ├── app.dart          # MaterialApp setup
│   ├── config/
│   │   ├── app_config.dart       # App constants
│   │   ├── themes.dart           # Dark/Light themes
│   │   └── localization.dart     # Multi-language support
│   ├── database/
│   │   └── database_helper.dart  # SQLite operations
│   ├── models/
│   │   ├── student.dart          # Student model (with imagePath & fatherContact)
│   │   ├── class_model.dart
│   │   └── settings.dart
│   ├── providers/
│   │   ├── student_provider.dart
│   │   ├── theme_provider.dart
│   │   ├── language_provider.dart
│   │   └── auth_provider.dart
│   ├── screens/
│   │   ├── splash_screen.dart
│   │   ├── lock_screen.dart
│   │   ├── home_screen.dart
│   │   ├── class_screen.dart
│   │   └── student_screen.dart   # Updated with camera integration
│   ├── services/
│   │   ├── contact_service.dart  # Call, SMS, WhatsApp
│   │   ├── image_service.dart    # Camera & gallery picker
│   │   ├── export_service.dart   # JSON/PDF export
│   │   └── share_service.dart
│   ├── widgets/
│   │   ├── class_card.dart
│   │   ├── roll_card.dart
│   │   ├── student_form.dart
│   │   ├── color_selector.dart
│   │   └── contact_actions.dart
│   └── utils/
│       ├── constants.dart
│       ├── helpers.dart
│       └── validators.dart
│
├── assets/
│   ├── icon/             # App icon (place app_icon.png here)
│   └── fonts/            # Custom fonts (Urdu support)
│
├── .github/
│   └── workflows/
│       └── build-apk.yml # GitHub Actions CI/CD
│
├── pubspec.yaml          # Dependencies
└── README.md             # This file
```

## 🎨 Key Dependencies

```yaml
dependencies:
  sqflite: ^2.3.0           # Local database
  image_picker: ^1.0.7      # Camera/Gallery
  url_launcher: ^6.2.1      # Call/SMS/WhatsApp
  share_plus: ^7.2.1        # Share functionality
  pdf: ^3.10.7              # PDF export
  provider: ^6.1.1          # State management
  permission_handler: ^11.1.0  # Runtime permissions
```

## 🔐 Permissions

### Android

```xml
<!-- AndroidManifest.xml -->
<uses-permission android:name="android.permission.CAMERA"/>
<uses-permission android:name="android.permission.READ_MEDIA_IMAGES"/>
<uses-permission android:name="android.permission.CALL_PHONE"/>
<uses-permission android:name="android.permission.SEND_SMS"/>
```

## 📸 Camera & Gallery

```dart
// services/image_service.dart

// Pick from camera
String? imagePath = await ImageService.pickImageFromCamera();

// Pick from gallery
String? imagePath = await ImageService.pickImageFromGallery();
```

## 📞 Contact Actions

```dart
// services/contact_service.dart

// Make phone call
await ContactService.makeCall(phoneNumber);

// Send SMS
await ContactService.sendSMS(phoneNumber, message);

// Send WhatsApp
await ContactService.sendWhatsApp(phoneNumber, message);
```

## 🗄️ Database Schema

```sql
-- Students table with image and father contact
CREATE TABLE students (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  classId INTEGER NOT NULL,
  rollNumber INTEGER NOT NULL,
  name TEXT,
  fatherName TEXT,
  contact TEXT,
  fatherContact TEXT,        -- New field
  address TEXT,
  comments TEXT,
  behaviorColor INTEGER NOT NULL,
  imagePath TEXT,            -- New field
  createdAt TEXT NOT NULL,
  updatedAt TEXT NOT NULL
);
```

## 🌍 Multi-language Support

- English
- Urdu (اردو)
- Roman Urdu

Toggle from Settings screen.

## 🔒 Security

- PIN/Password lock screen
- Secure storage using `flutter_secure_storage`
- Offline-only (no internet required)

## 🐛 Troubleshooting

### Build Fails

1. **Clean build**
   ```bash
   flutter clean
   flutter pub get
   flutter build apk
   ```

2. **Check Java version**
   ```bash
   java --version  # Should be 17
   ```

3. **Update Flutter**
   ```bash
   flutter upgrade
   ```

### Camera Not Working

1. Check permissions in AndroidManifest.xml
2. Run-time permission request implemented
3. Test on physical device (not emulator)

### GitHub Actions Fails

1. Check `.github/workflows/build-apk.yml`
2. Ensure Flutter version matches (3.24.0)
3. Verify `actions/upload-artifact@v4` is used

## 📝 License

Private project for educational purposes.

## 👤 Author

Built with ❤️ using Flutter

---

## 📋 Checklist for New Setup

- [ ] Flutter SDK installed
- [ ] Android Studio configured
- [ ] Java 17 installed
- [ ] Clone repository
- [ ] Run `flutter pub get`
- [ ] Place app icon in `assets/icon/`
- [ ] Run `flutter pub run flutter_launcher_icons`
- [ ] Test on device: `flutter run`
- [ ] Build APK: `flutter build apk`
- [ ] Push to GitHub for CI/CD build

## 🎯 GitHub Actions Output

After pushing to GitHub:

1. Go to **Actions** tab
2. Select latest workflow run
3. Wait for ✅ green checkmark
4. Click on workflow run
5. Scroll to **Artifacts** section
6. Download **EV-App-Release.zip**
7. Extract and install `app-release.apk`

---

**Note**: This version includes all fixes from previous build failures:
- ✅ Correct file names (`styles.xml` not `style.xml`)
- ✅ Complete Android resource structure
- ✅ Camera and gallery integration
- ✅ Dual contact fields (student + father)
- ✅ GitHub Actions with APK upload
- ✅ All permissions and queries properly configured
