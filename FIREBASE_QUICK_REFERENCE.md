# Firebase Integration - Quick Reference

## 🎉 What's Been Completed

### ✅ All Core Services Created and Ready to Use

1. **Firebase Authentication Service** (`lib/services/firebase_auth_service.dart`)
   ```dart
   final authService = FirebaseAuthService();
   
   // Register
   await authService.signUp(
     email: 'user@example.com',
     password: 'password123',
     firstName: 'John',
     lastName: 'Doe',
     phone: '1234567890',
   );
   
   // Login
   await authService.login(
     email: 'user@example.com',
     password: 'password123',
   );
   
   // Logout
   await authService.logout();
   
   // Get current user
   User? user = authService.currentUser;
   
   // Listen to auth state changes
   authService.authStateChanges.listen((user) {
     if (user == null) {
       // User logged out
     } else {
       // User logged in
     }
   });
   ```

2. **Firestore Event Service** (`lib/services/firestore_event_service.dart`)
   ```dart
   final eventService = FirestoreEventService();
   
   // Create event
   String eventId = await eventService.createEvent(
     userId: uid,
     title: 'Flutter Conference',
     category: 'Technology',
     description: 'Annual Flutter conference',
     eventDate: DateTime.now(),
     location: 'NYC',
     imageUrl: 'https://...',
   );
   
   // Get all events (real-time)
   Stream<List<Event>> events = eventService.getAllEvents();
   
   // Search events
   Stream<List<Event>> results = eventService.searchEvents('Flutter');
   
   // Get user's events
   Stream<List<Event>> userEvents = eventService.getUserCreatedEvents(userId);
   ```

3. **User Profile Service** (`lib/services/user_profile_service.dart`)
   ```dart
   final profileService = UserProfileService();
   
   // Create profile
   await profileService.createUserProfile(
     userId: uid,
     firstName: 'John',
     lastName: 'Doe',
     email: 'john@example.com',
     phone: '1234567890',
   );
   
   // Get profile
   Map<String, dynamic>? profile = await profileService.getUserProfile(uid);
   
   // Stream profile (real-time)
   Stream<Map<String, dynamic>?> profileStream = 
     profileService.getUserProfileStream(uid);
   
   // Add to attending events
   await profileService.addAttendingEvent(
     userId: uid,
     eventId: eventId,
   );
   ```

4. **Firebase Storage Service** (`lib/services/firebase_storage_service.dart`)
   ```dart
   final storageService = FirebaseStorageService();
   
   // Upload event image
   String imageUrl = await storageService.uploadEventImage(
     userId: uid,
     eventId: eventId,
     imageFile: File('path/to/image.jpg'),
   );
   
   // Upload profile image
   String profileImageUrl = await storageService.uploadProfileImage(
     userId: uid,
     imageFile: File('path/to/profile.jpg'),
   );
   
   // Delete image
   await storageService.deleteImage(imageUrl);
   ```

### ✅ Updated Components

- **lib/main.dart** - Firebase initialization on app startup
- **lib/pages/login_page.dart** - Connected to Firebase Auth
- **lib/models/event.dart** - Firestore serialization support
- **pubspec.yaml** - Firebase dependencies added

### ✅ Documentation Created

- **FIREBASE_SETUP.md** - Complete setup instructions
- **FIREBASE_INTEGRATION_STATUS.md** - Progress and status

## 🔑 Next Steps for User

### 1. Create Firebase Project (5-10 minutes)
- Go to https://console.firebase.google.com
- Click "Create a project"
- Name it "EventEase"
- Enable Google Analytics (optional)
- Click "Create project"

### 2. Register Your App
**For Android:**
- Click "Add app" → Android
- Package name: `com.example.eventease`
- Download `google-services.json`
- Place in: `android/app/google-services.json`

**For iOS:**
- Click "Add app" → iOS  
- Bundle ID: `com.example.eventease`
- Download `GoogleService-Info.plist`
- Place in: `ios/Runner/GoogleService-Info.plist`

### 3. Enable Services
1. **Authentication**
   - Go to "Authentication" → "Sign-in method"
   - Enable "Email/Password"

2. **Firestore Database**
   - Go to "Firestore Database"
   - Click "Create database"
   - Select "Test mode" for development
   - Choose nearest region

3. **Cloud Storage**
   - Go to "Storage"
   - Click "Get started"
   - Select "Test mode"

### 4. Get Configuration
- Go to Project Settings (gear icon)
- Under "Your apps", click your app
- Copy the Firebase config values

### 5. Update firebase_options.dart
Replace the placeholder values in `lib/firebase_options.dart` with your actual Firebase configuration.

## 📋 Database Schema (Ready to Use)

### Users Collection
```
users/
  {userId}/
    - firstName: string
    - lastName: string
    - email: string
    - phone: string
    - profileImageUrl: string
    - bio: string
    - createdAt: timestamp
    - updatedAt: timestamp
    - attendingEvents: array
    - createdEventsCount: number
```

### Events Collection
```
events/
  {eventId}/
    - userId: string (creator)
    - title: string
    - category: string
    - description: string
    - eventDate: timestamp
    - location: string
    - imageUrl: string
    - createdAt: timestamp
    - updatedAt: timestamp
    - attendees: array (objects with userId, userName)
    - attendeeCount: number
```

## 🔒 Security Rules Ready

**Firestore Rules:**
```firebase
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /users/{userId} {
      allow read: if request.auth.uid == userId;
      allow write: if request.auth.uid == userId;
    }
    match /events/{eventId} {
      allow read: if true;
      allow write: if request.auth.uid == resource.data.userId;
      allow create: if request.auth.uid != null;
      allow delete: if request.auth.uid == resource.data.userId;
    }
  }
}
```

**Storage Rules:**
```firebase
rules_version = '2';
service firebase.storage {
  match /b/{bucket}/o {
    match /events/{userId}/{eventId}/{allPaths=**} {
      allow read: if true;
      allow write: if request.auth.uid == userId;
    }
    match /profiles/{userId}/{allPaths=**} {
      allow read: if true;
      allow write: if request.auth.uid == userId;
    }
  }
}
```

## 💻 Common Usage Patterns

### Real-time Event Listing
```dart
StreamBuilder<List<Event>>(
  stream: FirestoreEventService().getAllEvents(),
  builder: (context, snapshot) {
    if (snapshot.hasData) {
      return ListView(
        children: snapshot.data!.map((event) => 
          EventCard(event: event)
        ).toList(),
      );
    }
    return CircularProgressIndicator();
  },
)
```

### User Authentication Check
```dart
class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuthService().authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LoadingScreen();
        }
        if (snapshot.hasData) {
          return MainAppShell();
        }
        return LoginPage();
      },
    );
  }
}
```

### Create Event with Image
```dart
Future<void> createEventWithImage() async {
  final authService = FirebaseAuthService();
  final eventService = FirestoreEventService();
  final storageService = FirebaseStorageService();
  final profileService = UserProfileService();
  
  // Upload image
  String imageUrl = await storageService.uploadEventImage(
    userId: authService.currentUser!.uid,
    eventId: 'temp_id',
    imageFile: selectedFile,
  );
  
  // Create event
  String eventId = await eventService.createEvent(
    userId: authService.currentUser!.uid,
    title: 'My Event',
    category: 'Technology',
    description: 'Description',
    eventDate: eventDateTime,
    location: 'NYC',
    imageUrl: imageUrl,
  );
  
  // Increment user's event count
  await profileService.incrementCreatedEventsCount(
    authService.currentUser!.uid,
  );
}
```

## ✨ Features Ready to Implement

1. **Real-time Event Updates** - All streams implemented
2. **Search & Filter** - Search method ready in EventService
3. **User Profiles** - Full CRUD operations ready
4. **Image Uploads** - Storage service fully implemented
5. **Attendee Management** - Attendee add/remove methods ready
6. **User Authentication** - Complete auth flow ready

## 📞 Troubleshooting

**"Firebase not initialized"**
- Make sure Firebase project is created
- Check firebase_options.dart has correct values

**"Permission denied in Firestore"**
- Check security rules are set correctly
- Verify user is authenticated
- Check that firestore_event_service is using correct userId

**"Image upload fails"**
- Verify Storage bucket is enabled
- Check storage security rules
- Ensure file path is correct

## 📚 Files Reference

- **Auth**: `lib/services/firebase_auth_service.dart`
- **Events**: `lib/services/firestore_event_service.dart`
- **Profiles**: `lib/services/user_profile_service.dart`
- **Storage**: `lib/services/firebase_storage_service.dart`
- **Config**: `lib/firebase_options.dart`
- **Model**: `lib/models/event.dart`
- **Setup Guide**: `FIREBASE_SETUP.md`

---

**Status**: Ready to deploy. Awaiting Firebase Console setup.
