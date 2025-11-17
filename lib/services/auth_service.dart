import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';
import 'local_storage_service.dart';

class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  final LocalStorageService _storageService = LocalStorageService();

  // Simple stream for auth state changes (mock)
  Stream<User?> get authStateChanges async* {
    final user = await _storageService.getCurrentUser();
    yield user;
  }

  // Get current user
  Future<User?> get currentUser async {
    return await _storageService.getCurrentUser();
  }

  // Sign up with email and password
  Future<User> signUp({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String phone,
  }) async {
    try {
      // Check if user already exists
      final users = await _storageService.getUsers();
      final existingUser = users.values.firstWhere(
        (user) => user.email == email,
        orElse: () => User.empty(), // Use empty user instead
      );

      if (existingUser.id.isNotEmpty) {
        throw Exception('Account already exists for that email.');
      }

      // Create new user
      final newUser = User(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        email: email,
        name: '$firstName $lastName',
        createdAt: DateTime.now(),
      );

      // Save user to local storage
      await _storageService.saveUser(newUser);
      await _storageService.setCurrentUser(newUser);

      return newUser;
    } catch (e) {
      throw Exception('Failed to create account: $e');
    }
  }

  // Login with email and password
  Future<User> login({
    required String email,
    required String password,
  }) async {
    try {
      // For demo - simple validation
      if (email.isEmpty || password.isEmpty) {
        throw Exception('Please enter email and password');
      }

      // Find user by email (in real app, you'd verify password)
      final users = await _storageService.getUsers();
      final user = users.values.firstWhere(
        (user) => user.email == email,
        orElse: () => User.empty(), // Use empty user instead
      );

      if (user.id.isEmpty) {
        throw Exception('User not found.');
      }

      // Simple password check (in real app, use proper hashing)
      if (password.length < 6) {
        throw Exception('Invalid email or password.');
      }

      // Set as current user
      await _storageService.setCurrentUser(user);

      return user;
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  // Password reset (mock - in real app, integrate with your backend)
  Future<void> resetPassword({required String email}) async {
    try {
      // Check if user exists
      final users = await _storageService.getUsers();
      final user = users.values.firstWhere(
        (user) => user.email == email,
        orElse: () => User.empty(), // Use empty user instead
      );

      if (user.id.isEmpty) {
        throw Exception('User not found.');
      }

      // In a real app, you'd send an email here
      // For now, just simulate success
      await Future.delayed(Duration(seconds: 1));
      
      print('Password reset email sent to $email');
    } catch (e) {
      throw Exception('Failed to reset password: $e');
    }
  }

  // Logout
  Future<void> logout() async {
    try {
      await _storageService.logout();
    } catch (e) {
      throw Exception('Failed to logout: $e');
    }
  }

  // Update user profile
  Future<User> updateProfile({
    required String userId,
    String? name,
    String? profilePictureUrl,
  }) async {
    try {
      final user = await _storageService.getUser(userId);
      if (user == null) {
        throw Exception('User not found');
      }

      final updatedUser = User(
        id: user.id,
        email: user.email,
        name: name ?? user.name,
        profilePictureUrl: profilePictureUrl ?? user.profilePictureUrl,
        createdAt: user.createdAt,
      );

      await _storageService.saveUser(updatedUser);
      
      // Update current user if it's the same user
      final currentUser = await _storageService.getCurrentUser();
      if (currentUser?.id == userId) {
        await _storageService.setCurrentUser(updatedUser);
      }

      return updatedUser;
    } catch (e) {
      throw Exception('Failed to update profile: $e');
    }
  }

  // Delete account
  Future<void> deleteAccount(String userId) async {
    try {
      await _storageService.logout();
      // In a real app, you'd also remove user data from storage
    } catch (e) {
      throw Exception('Failed to delete account: $e');
    }
  }
}