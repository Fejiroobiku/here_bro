import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Upload event image
  Future<String> uploadEventImage({
    required String userId,
    required String eventId,
    required File imageFile,
  }) async {
    try {
      final fileName = 'events/$userId/$eventId/${DateTime.now().millisecondsSinceEpoch}.jpg';
      
      final ref = _storage.ref().child(fileName);
      final uploadTask = ref.putFile(imageFile);
      
      final snapshot = await uploadTask;
      final downloadUrl = await snapshot.ref.getDownloadURL();
      
      return downloadUrl;
    } catch (e) {
      throw Exception('Failed to upload image: $e');
    }
  }

  // Upload profile image
  Future<String> uploadProfileImage({
    required String userId,
    required File imageFile,
  }) async {
    try {
      final fileName = 'profiles/$userId/profile_${DateTime.now().millisecondsSinceEpoch}.jpg';
      
      final ref = _storage.ref().child(fileName);
      final uploadTask = ref.putFile(imageFile);
      
      final snapshot = await uploadTask;
      final downloadUrl = await snapshot.ref.getDownloadURL();
      
      return downloadUrl;
    } catch (e) {
      throw Exception('Failed to upload profile image: $e');
    }
  }

  // Delete image by URL
  Future<void> deleteImage(String imageUrl) async {
    try {
      final ref = _storage.refFromURL(imageUrl);
      await ref.delete();
    } catch (e) {
      throw Exception('Failed to delete image: $e');
    }
  }

  // Delete event folder (all images)
  Future<void> deleteEventFolder({
    required String userId,
    required String eventId,
  }) async {
    try {
      final ref = _storage.ref().child('events/$userId/$eventId');
      final items = await ref.listAll();
      
      for (var item in items.items) {
        await item.delete();
      }
    } catch (e) {
      throw Exception('Failed to delete event folder: $e');
    }
  }

  // Get download URL from storage path
  Future<String> getDownloadUrl(String storagePath) async {
    try {
      return await _storage.ref().child(storagePath).getDownloadURL();
    } catch (e) {
      throw Exception('Failed to get download URL: $e');
    }
  }
}
