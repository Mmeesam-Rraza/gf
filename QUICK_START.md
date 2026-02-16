# ⚡ Quick Start Guide - EV App

## 🎯 For Immediate Use

### Step 1: Extract
```bash
unzip ev_app_fixed_complete.zip
cd ev_app
```

### Step 2: Install Dependencies
```bash
flutter pub get
```

### Step 3: Build APK
```bash
flutter build apk --release
```

### Step 4: Install
```bash
# APK is at: build/app/outputs/flutter-apk/app-release.apk
# Install on device or use GitHub Actions
```

---

## 📦 What's in the ZIP?

```
ev_app/
├── 📄 README.md               - Full documentation
├── 📄 BUILD_INSTRUCTIONS.md   - Detailed build guide
├── 📄 FIXES_SUMMARY.md        - All fixes documented
├── 📄 QUICK_START.md          - This file
│
├── android/                   - ✅ All fixes applied
│   ├── app/
│   │   ├── build.gradle
│   │   └── src/main/
│   │       ├── AndroidManifest.xml  ✅ Permissions + Queries
│   │       ├── res/
│   │       │   ├── values/
│   │       │   │   └── styles.xml   ✅ CORRECT NAME
│   │       │   └── drawable/
│   │       │       └── launch_background.xml  ✅ ADDED
│   │       └── kotlin/.../MainActivity.kt
│   └── ...
│
├── lib/                       - ✅ Camera + Dual Contacts
│   ├── services/
│   │   ├── image_service.dart       ✅ NEW
│   │   └── contact_service.dart
│   ├── screens/
│   │   └── student_screen.dart      ✅ UPDATED
│   ├── models/
│   │   └── student.dart             ✅ UPDATED
│   └── database/
│       └── database_helper.dart     ✅ UPDATED
│
├── .github/workflows/
│   └── build-apk.yml          ✅ APK upload fixed
│
└── pubspec.yaml               ✅ Dependencies added
```

---

## ✅ All Fixes Applied

1. ✅ **styles.xml** - Correct name (was style.xml)
2. ✅ **launch_background.xml** - Added
3. ✅ **Camera** - Full integration
4. ✅ **Gallery** - Full integration
5. ✅ **Dual Contacts** - Student + Father
6. ✅ **Database** - imagePath + fatherContact columns
7. ✅ **Permissions** - All Android 11+ queries
8. ✅ **GitHub Actions** - APK artifact upload

---

## 🚀 Fastest Build Method

### Option A: Local
```bash
cd ev_app
flutter clean && flutter pub get && flutter build apk --release
```

### Option B: GitHub Actions
```bash
git init
git add .
git commit -m "EV App - All fixes applied"
git remote add origin <your-repo>
git push -u origin main
# Wait for GitHub Actions → Download APK from Artifacts
```

---

## 📱 Test Camera Feature

1. Open app
2. Select any class
3. Select any roll number
4. Tap **"Add Photo"** button
5. Choose:
   - **Camera** ✅ Takes photo
   - **Gallery** ✅ Selects from gallery
6. Photo appears in profile ✅

---

## 📞 Test Contact Features

1. Add student contact number
2. Add father contact number
3. Tap contact → Instant call ✅
4. Long press → Menu:
   - Call ✅
   - SMS ✅ (pre-filled message)
   - WhatsApp ✅ (pre-filled message)

---

## 🎨 Test Other Features

- **Dark Mode**: Settings → Toggle theme ✅
- **Language**: Settings → English/Urdu/Roman Urdu ✅
- **Behavior Colors**: Select color → Background changes ✅
- **Export**: Menu → Export JSON/PDF ✅
- **PIN Lock**: First launch → Set PIN ✅

---

## 📋 Pre-Build Checklist

- [ ] Flutter SDK installed (3.24.0+)
- [ ] Android SDK configured
- [ ] Java 17 installed
- [ ] `flutter doctor` shows no errors

---

## 🆘 If Build Fails

```bash
# Full clean
flutter clean
rm -rf build/
cd android && ./gradlew clean && cd ..

# Reinstall
flutter pub get

# Rebuild
flutter build apk --release
```

---

## 📊 Expected Results

- **Build Time**: 3-5 minutes
- **APK Size**: ~40-50 MB
- **Min Android**: 5.0 (API 21)
- **Target Android**: 14 (API 34)

---

## ✅ Success Indicators

After build:
```
✓ Built build/app/outputs/flutter-apk/app-release.apk (XX.XMB)
```

After install:
- App icon appears
- App opens without crash
- All features work
- Camera captures photos
- Contacts trigger actions
- Data persists

---

## 🎯 Most Important Files

If you only check 5 files:

1. `android/app/src/main/res/values/styles.xml` ✅
2. `android/app/src/main/AndroidManifest.xml` ✅
3. `lib/services/image_service.dart` ✅
4. `lib/screens/student_screen.dart` ✅
5. `.github/workflows/build-apk.yml` ✅

All are correct and ready to use!

---

## 📖 Need More Help?

- **Full Setup**: Read `BUILD_INSTRUCTIONS.md`
- **All Features**: Read `README.md`
- **What Changed**: Read `FIXES_SUMMARY.md`

---

## ⏱️ Time to Production

- **Setup**: 5 minutes
- **Build**: 3-5 minutes
- **Test**: 5 minutes
- **Total**: ~15 minutes to working APK

---

**You're ready to go! 🚀**
