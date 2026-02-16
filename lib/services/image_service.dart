import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:permission_handler/permission_handler.dart';

class ImageService {
  static final ImagePicker _picker = ImagePicker();

  static Future<String?> pickImageFromCamera() async {
    final cameraStatus = await Permission.camera.request();
    
    if (!cameraStatus.isGranted) {
      return null;
    }

    try {
      final XFile? photo = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );

      if (photo == null) return null;

      return await _saveImage(photo);
    } catch (e) {
      print('Error taking photo: $e');
      return null;
    }
  }

  static Future<String?> pickImageFromGallery() async {
    final storageStatus = await Permission.photos.request();
    
    if (!storageStatus.isGranted) {
      final mediaStatus = await Permission.mediaLibrary.request();
      if (!mediaStatus.isGranted) {
        return null;
      }
    }

    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );

      if (image == null) return null;

      return await _saveImage(image);
    } catch (e) {
      print('Error picking image: $e');
      return null;
    }
  }

  static Future<String> _saveImage(XFile xFile) async {
    final appDir = await getApplicationDocumentsDirectory();
    final fileName = '${DateTime.now().millisecondsSinceEpoch}${path.extension(xFile.path)}';
    final savedPath = path.join(appDir.path, 'student_photos', fileName);
    
    final directory = Directory(path.dirname(savedPath));
    if (!await directory.exists()) {
      await directory.create(recursive: true);
    }

    final file = File(xFile.path);
    await file.copy(savedPath);
    
    return savedPath;
  }

  static Future<void> deleteImage(String? imagePath) async {
    if (imagePath == null || imagePath.isEmpty) return;
    
    try {
      final file = File(imagePath);
      if (await file.exists()) {
        await file.delete();
      }
    } catch (e) {
      print('Error deleting image: $e');
    }
  }
}