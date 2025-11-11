# Firebase Console Setup Guide for EventEase App

**Current Date:** November 11, 2025

## Overview
This guide walks you through configuring your Firebase project in the Firebase Console after creating a new project.

---

## ✅ Step 1: Enable Authentication Methods

### 1.1 Enable Email/Password Authentication
```
Firebase Console → Authentication → Sign-in method
```

**Steps:**
1. Click on **"Sign-in method"** tab
2. Click **"Email/Password"** provider
3. Toggle **"Enable"** to ON
4. Click **"Save"**

**Why?** Your app uses email/password for login and registration.

---

## ✅ Step 2: Create Firestore Database

### 2.1 Create Cloud Firestore
```
Firebase Console → Firestore Database → Create Database
```

**Steps:**
1. Click **"Create Database"**
2. Select **Region:** `us-central1` (or closest to your users)
3. Select **Mode:** Choose **"Start in production mode"** (you'll update rules in step 2.2)
4. Click **"Create"**

**Why?** Firestore stores all your event and user data.

### 2.2 Set Firestore Security Rules

After database is created:

1. Go to **Firestore Database** → **Rules** tab
2. Replace all content with:

```firestore
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    
    // Users collection - only users can read/write their own profile
    match /users/{userId} {
      allow read: if request.auth.uid == userId;
      allow write: if request.auth.uid == userId;
      
      // User's created events subcollection
      match /createdEvents/{eventId} {
        allow read: if request.auth.uid == userId;
        allow write: if request.auth.uid == userId;
      }
    }
    
    // Events collection - anyone can read, only owner can write
    match /events/{eventId} {
      allow read: if true;
      allow create: if request.auth != null;
      allow update, delete: if request.auth.uid == resource.data.organizerId;
      
      // Attendees subcollection
      match /attendees/{userId} {
        allow read: if true;
        allow write: if request.auth.uid == userId;
      }
    }
  }
}
```

3. Click **"Publish"**

**Why?** These rules ensure:
- Users can only access their own profile
- Anyone can browse events
- Only event creators can edit/delete their events

---

## ✅ Step 3: Enable Cloud Storage

### 3.1 Create Cloud Storage Bucket
```
Firebase Console → Storage → Get Started
```

**Steps:**
1. Click **"Get Started"**
2. Keep default bucket name (usually: `projectname.appspot.com`)
3. Select **Location:** `us-central1`
4. Click **"Done"**

### 3.2 Set Storage Security Rules

1. Go to **Storage** → **Rules** tab
2. Replace all content with:

```
rules_version = '2';
service firebase.storage {
  match /b/{bucket}/o {
    // Event images - anyone can read, only owner can write
    match /events/{eventId}/{fileName} {
      allow read: if true;
      allow write: if request.auth != null;
      allow delete: if request.auth != null;
    }
    
    // Profile images - only user can read/write their own
    match /profiles/{userId}/{fileName} {
      allow read: if request.auth.uid == userId;
      allow write: if request.auth.uid == userId;
      allow delete: if request.auth.uid == userId;
    }
  }
}
```

3. Click **"Publish"**

**Why?** These rules ensure:
- Event images are publicly viewable but only authenticated users can upload
- Profile images are private to each user

---

## ✅ Step 4: Get Firebase Configuration Credentials

### 4.1 Download Firebase Config File

```
Firebase Console → Project Settings (⚙️) → Your apps → Google-services.json (Android) / GoogleService-Info.plist (iOS)
```

**For Android:**
1. Click **"Your apps"** section
2. Click on your **Android app**
3. Click **"google-services.json"** download button
4. Save to: `android/app/google-services.json`

**For iOS:**
1. Click **"Your apps"** section
2. Click on your **iOS app**
3. Click **"GoogleService-Info.plist"** download button
4. In Xcode: Right-click `Runner` → **Add Files to Runner** → Select the plist

### 4.2 Get Firebase Options for Dart

```
Firebase Console → Project Settings (⚙️) → General
```

**Collect these values:**
- Project ID
- Web API Key (under "Your apps" → Web)
- Storage Bucket
- Auth Domain

**You'll need these for `firebase_options.dart`**

---

## ✅ Step 5: Create Firestore Collections & Indexes

### 5.1 Create Collections

#### Users Collection
```
Collection: users
Document ID: {userId} (auto-generated from Firebase Auth)
Fields:
- email (string)
- firstName (string)
- lastName (string)
- bio (string)
- profileImageUrl (string)
- createdEventsCount (number) - default: 0
- attendingEvents (array) - default: []
- createdAt (timestamp)
- updatedAt (timestamp)
```

#### Events Collection
```
Collection: events
Document ID: {eventId} (auto-generated)
Fields:
- id (string)
- title (string)
- description (string)
- date (timestamp)
- time (string)
- location (string)
- category (string)
- imageUrl (string)
- organizerId (string) - references users/{userId}
- attendees (number) - default: 0
- attendeesList (array of userIds)
- createdAt (timestamp)
- updatedAt (timestamp)
```

**How to create:**
1. Go to **Firestore Database** → **Data** tab
2. Click **"Start collection"**
3. Enter collection name (e.g., "users")
4. Click **"Next"**
5. Add first document manually (or let the app create it)

---

## ✅ Step 6: (Optional) Set Up Firestore Indexes

For search queries to work efficiently:

```
Firebase Console → Firestore Database → Indexes
```

**Create Index for Event Search:**
1. Click **"Create Index"**
2. Collection: `events`
3. Add fields:
   - Field 1: `category` (Ascending)
   - Field 2: `date` (Descending)
4. Click **"Create Index"**

**Note:** Firestore will auto-create indexes for most queries. This step is optional but recommended for performance.

---

## ✅ Step 7: Configure Your App with Firebase Credentials

### 7.1 Update `firebase_options.dart`

**Location:** `lib/firebase_options.dart`

Replace the template with your actual credentials:

```dart
import 'package:firebase_core/firebase_core.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    return FirebaseOptions(
      apiKey: "YOUR_WEB_API_KEY", // From Firebase Console
      appId: "YOUR_APP_ID", // From google-services.json
      messagingSenderId: "YOUR_MESSAGING_SENDER_ID",
      projectId: "YOUR_PROJECT_ID", // From Firebase Console
      authDomain: "YOUR_PROJECT_ID.firebaseapp.com",
      storageBucket: "YOUR_PROJECT_ID.appspot.com",
      iosBundleId: "YOUR_IOS_BUNDLE_ID",
      androidPackageName: "YOUR_ANDROID_PACKAGE_NAME",
    );
  }
}
```

**Where to find these values:**
```
Firebase Console → Project Settings (⚙️)
- projectId: Under "General"
- apiKey: Under "Your apps" → Web app (if created)
- appId: Under "Your apps" → Your app
- storageBucket: Usually "{projectId}.appspot.com"
- authDomain: Usually "{projectId}.firebaseapp.com"
```

### 7.2 Verify `main.dart` is configured

Your `lib/main.dart` should have:

```dart
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  runApp(const MyApp());
}
```

---

## ✅ Step 8: Test Firebase Connection

### 8.1 Run Your App
```bash
flutter run
```

### 8.2 Test Authentication
1. Click **Register** on the app
2. Create a test account with:
   - Email: `test@example.com`
   - Password: `Test123!`
   - Name: `Test User`

3. Check Firebase Console:
   ```
   Firebase Console → Authentication → Users
   ```
   Your new user should appear! ✅

### 8.3 Test Firestore Write
If registration succeeds, check:
```
Firebase Console → Firestore Database → Data
```
You should see:
```
users
└── {userId}
    ├── email: "test@example.com"
    ├── firstName: "Test"
    └── lastName: "User"
```

---

## 📋 Firebase Console Checklist

- [ ] **Step 1:** Email/Password authentication enabled
- [ ] **Step 2:** Firestore database created (production mode)
- [ ] **Step 2.2:** Firestore security rules published
- [ ] **Step 3:** Cloud Storage bucket created
- [ ] **Step 3.2:** Storage security rules published
- [ ] **Step 4.1:** `google-services.json` downloaded to `android/app/`
- [ ] **Step 4.1:** `GoogleService-Info.plist` added to iOS (Xcode)
- [ ] **Step 4.2:** Firebase credentials collected
- [ ] **Step 5:** Firestore collections structure understood (users, events)
- [ ] **Step 7.1:** `firebase_options.dart` updated with real credentials
- [ ] **Step 7.2:** `main.dart` Firebase initialization verified
- [ ] **Step 8:** Test account created and verified in Firebase Console

---

## 🆘 Troubleshooting

### Error: "Firebase initialization failed"
**Solution:** Check that `firebase_options.dart` has correct credentials from Firebase Console

### Error: "Permission denied" when saving events
**Solution:** Check Firestore security rules are published (Step 2.2)

### Error: "Storage bucket not found"
**Solution:** Ensure Cloud Storage is enabled (Step 3.1)

### New user doesn't appear in Firebase Console
**Solution:** 
1. Check app console logs for errors
2. Verify `UserProfileService.createUserProfile()` is called after signup
3. Check Firestore security rules allow writes (Step 2.2)

---

## 📚 Related Files in Your Project

- `lib/main.dart` - Firebase initialization
- `lib/firebase_options.dart` - Firebase credentials template
- `lib/services/firebase_auth_service.dart` - Authentication
- `lib/services/firestore_event_service.dart` - Events database
- `lib/services/user_profile_service.dart` - User profiles
- `lib/services/firebase_storage_service.dart` - Image uploads
- `android/app/build.gradle.kts` - Android Firebase plugin
- `ios/Runner/Info.plist` - iOS Firebase configuration

---

## 🎯 Next Steps After Setup

1. ✅ Complete this Firebase Console setup
2. ✅ Update `firebase_options.dart` with real credentials
3. ✅ Run `flutter pub get`
4. ✅ Run `flutter run` and test registration
5. ✅ Verify data appears in Firebase Console
6. Update CreateEventPage with event creation
7. Test all features end-to-end
8. Deploy to production

---

**Happy Firebase Setup! 🚀**
