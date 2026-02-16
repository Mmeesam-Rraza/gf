# 🚀 EV App - Complete Build Instructions

## ✅ All Previous Errors FIXED

### What Was Wrong (and is now FIXED)
1. ✅ **styles.xml** - File name was incorrect (`style.xml` → `styles.xml`)
2. ✅ **launch_background.xml** - Was missing from drawable folder
3. ✅ **Icon structure** - All mipmap folders now properly configured
4. ✅ **Camera integration** - Complete camera & gallery support added
5. ✅ **Dual contacts** - Student + Father contact fields implemented
6. ✅ **Database schema** - Added `imagePath` and `fatherContact` columns
7. ✅ **GitHub Actions** - APK upload artifact now included
8. ✅ **Permissions** - All Android 11+ queries and permissions added
9. ✅ **Preview files removed** - Unnecessary SVG previews deleted

---

## 📋 Prerequisites

### Required Software
- **Flutter SDK**: 3.24.0 or higher
- **Android Studio**: Latest version
- **Java JDK**: Version 17
- **Git**: For version control

### Check Your Setup
```bash
flutter doctor -v
java --version
```

---

## 🔧 Step-by-Step Setup

### 1. Extract/Clone the Project
```bash
# If from ZIP
unzip EV_FIXED.zip
cd ev_app

# If from Git
git clone <your-repo-url>
cd ev_app
```

### 2. Install Flutter Dependencies
```bash
flutter pub get
```

### 3. Configure App Icon (Optional but Recommended)
```bash
# Place your 1024x1024 PNG icon as:
# assets/icon/app_icon.png

# Generate all icon sizes
flutter pub run flutter_launcher_icons
```

### 4. Configure Android SDK Path
```bash
# Copy the template
cp android/local.properties.template android/local.properties

# Edit android/local.properties
# Set your Android SDK path:
# Windows: sdk.dir=C:\\Users\\YourName\\AppData\\Local\\Android\\sdk
# Mac/Linux: sdk.dir=/Users/YourName/Library/Android/sdk
```

---

## 🏗️ Building the APK

### Method 1: Local Build (Recommended for Testing)
```bash
# Clean previous builds
flutter clean

# Get dependencies
flutter pub get

# Build release APK
flutter build apk --release

# APK will be at:
# build/app/outputs/flutter-apk/app-release.apk
```

### Method 2: Build with Split ABIs (Smaller File Size)
```bash
flutter build apk --split-per-abi

# Generates 3 APKs:
# app-armeabi-v7a-release.apk (32-bit ARM)
# app-arm64-v8a-release.apk (64-bit ARM - most devices)
# app-x86_64-release.apk (64-bit Intel)
```

### Method 3: GitHub Actions (CI/CD)

1. **Push code to GitHub**
   ```bash
   git add .
   git commit -m "Initial commit with all fixes"
   git push origin main
   ```

2. **GitHub will automatically**:
   - Detect the push
   - Run `.github/workflows/build-apk.yml`
   - Build the APK
   - Upload as artifact

3. **Download the APK**:
   - Go to GitHub → Actions tab
   - Click on latest workflow run
   - Wait for green ✅ checkmark
   - Scroll to "Artifacts" section
   - Download `EV-App-Release.zip`
   - Extract and get `app-release.apk`

---

## 🧪 Testing

### Run on Emulator
```bash
# Start Android emulator from Android Studio
# Then run:
flutter run
```

### Run on Physical Device
```bash
# Enable USB debugging on your Android device
# Connect via USB
# Run:
flutter run

# Or install APK directly:
adb install build/app/outputs/flutter-apk/app-release.apk
```

---

## 🔍 Troubleshooting

### Issue: Build fails with "styles.xml not found"
**Solution**: File is now correctly named as `styles.xml` in:
```
android/app/src/main/res/values/styles.xml
```

### Issue: "launch_background.xml not found"
**Solution**: File now exists at:
```
android/app/src/main/res/drawable/launch_background.xml
```

### Issue: Camera not working
**Causes**:
1. No camera permission
2. Running on emulator without camera

**Solution**:
- Permissions are already added in `AndroidManifest.xml`
- Test on a physical device
- Check Settings → Apps → EV → Permissions

### Issue: "Gradle sync failed"
**Solution**:
```bash
cd android
./gradlew clean
cd ..
flutter clean
flutter pub get
flutter build apk
```

### Issue: "SDK location not found"
**Solution**:
Create `android/local.properties`:
```properties
sdk.dir=/path/to/Android/sdk
flutter.sdk=/path/to/flutter
```

### Issue: GitHub Actions build fails
**Check**:
1. Workflow file exists: `.github/workflows/build-apk.yml`
2. Using correct Flutter version (3.24.0)
3. Using `actions/upload-artifact@v4` (not v3)

---

## 📂 Project Structure Verification

### Critical Files Checklist
- ✅ `pubspec.yaml` - Dependencies configured
- ✅ `android/app/build.gradle` - Build config
- ✅ `android/app/src/main/AndroidManifest.xml` - Permissions & queries
- ✅ `android/app/src/main/res/values/styles.xml` - (**Correct name**)
- ✅ `android/app/src/main/res/drawable/launch_background.xml` - Splash screen
- ✅ `lib/services/image_service.dart` - Camera/gallery
- ✅ `lib/services/contact_service.dart` - Call/SMS/WhatsApp
- ✅ `lib/database/database_helper.dart` - Updated schema
- ✅ `lib/models/student.dart` - With imagePath & fatherContact
- ✅ `.github/workflows/build-apk.yml` - CI/CD with artifact upload

---

## 🎯 Features Verification

After building and installing, verify:

### 1. Camera Integration
- Open any student
- Click "Add Photo" button
- Select "Camera" → Should open camera
- Select "Gallery" → Should open gallery
- Photo should display in student profile

### 2. Dual Contacts
- Add student contact number
- Add father contact number
- Both should show in profile
- Both should have Call/SMS/WhatsApp buttons

### 3. WhatsApp Integration
- Click WhatsApp on any contact
- Should open WhatsApp with pre-filled message:
```
Name: [Student Name]
Roll: [Number]
Status: [Behavior Color]
Comment: [Comment]
Class: [Class Name]
```

### 4. Multi-Language
- Go to Settings
- Toggle between: English / Urdu / Roman Urdu
- UI text should change

### 5. Dark Mode
- Go to Settings
- Toggle Dark Mode
- App theme should switch

---

## 📦 Final APK Details

### APK Specifications
- **Package Name**: com.evapp.student
- **Min SDK**: 21 (Android 5.0)
- **Target SDK**: 34 (Android 14)
- **Size**: ~40-50 MB (depending on assets)

### Permissions Required
- ✅ Camera
- ✅ Read Media Images
- ✅ Call Phone
- ✅ Send SMS
- ✅ Internet (for WhatsApp web intent)

---

## 🔐 Security Notes

- **Password Lock**: First-time setup requires PIN
- **Data Storage**: All data stored locally in SQLite
- **No Cloud**: App works 100% offline
- **Privacy**: No data leaves the device

---

## 📞 Support Commands

### Clean Everything
```bash
flutter clean
cd android && ./gradlew clean && cd ..
rm -rf build/
flutter pub get
```

### Check Dependencies
```bash
flutter pub outdated
flutter pub upgrade
```

### Analyze Code
```bash
flutter analyze
```

### Run Tests
```bash
flutter test
```

---

## ✅ Success Checklist

Before considering the app "ready":

- [ ] App builds without errors
- [ ] APK installs on device
- [ ] All 12 classes load correctly
- [ ] Can add/edit students
- [ ] Camera captures photos successfully
- [ ] Gallery picker works
- [ ] Photos display in student profiles
- [ ] Call button opens dialer
- [ ] SMS button opens messages app
- [ ] WhatsApp button opens WhatsApp
- [ ] Both student and father contacts work
- [ ] Behavior colors change background
- [ ] Dark mode toggles properly
- [ ] Language changes work
- [ ] Export to JSON works
- [ ] Export to PDF works
- [ ] PIN lock functions
- [ ] Data persists after app restart

---

## 🎉 You're Done!

Your EV Student Management App is now ready to use!

### Quick Start Commands:
```bash
# Build and run in one step
flutter run --release

# Just build APK
flutter build apk --release

# Install on connected device
flutter install
```

---

**Note**: All previous build errors have been fixed. If you encounter any new issues, check the troubleshooting section or verify that all critical files are present.
