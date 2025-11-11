# Firebase Setup Guide for EventEase

## Database Schema

### Collections Structure

```
firestore/
├── users/
│   └── {userId}
│       ├── firstName: string
│       ├── lastName: string
│       ├── email: string
│       ├── phone: string
│       ├── profileImageUrl: string (optional)
│       ├── bio: string (optional)
│       ├── createdAt: timestamp
│       ├── updatedAt: timestamp
│       ├── attendingEvents: array<string> (event IDs)
│       └── createdEventsCount: number
│
└── events/
    └── {eventId}
        ├── userId: string (creator's user ID)
        ├── title: string
        ├── category: string (Business, Sports, Music, Art, Technology, etc.)
        ├── description: string
        ├── eventDate: timestamp
        ├── location: string
        ├── imageUrl: string
        ├── createdAt: timestamp
        ├── updatedAt: timestamp
        ├── attendees: array<object>
        │   └── [{ userId: string, userName: string }]
        └── attendeeCount: number
```

## Step 1: Create Firebase Project

1. Go to [Firebase Console](https://console.firebase.google.com)
2. Click "Create a project" or "Add project"
3. Enter project name: `EventEase` (or your preferred name)
4. Disable Google Analytics (optional)
5. Click "Create project"

## Step 2: Register Your App

### For Android:
1. In Firebase Console, click "Add app" → Android
2. Enter package name: `com.example.eventease`
3. Download `google-services.json`
4. Place it in: `android/app/google-services.json`

### For iOS:
1. Click "Add app" → iOS
2. Enter bundle ID: `com.example.eventease`
3. Download `GoogleService-Info.plist`
4. Place it in: `ios/Runner/GoogleService-Info.plist`

### For Web:
1. Click "Add app" → Web
2. Copy the Firebase config (you'll need it for firebase_options.dart)

## Step 3: Enable Authentication

1. Go to **Authentication** → **Sign-in method**
2. Enable **Email/Password**
   - Click on "Email/Password"
   - Toggle "Enable"
   - Save

## Step 4: Create Firestore Database

1. Go to **Firestore Database**
2. Click **"Create database"**
3. Choose region (closest to your location)
4. Select **"Start in test mode"** for development
   - **⚠️ Production mode**: Update security rules later!
5. Click "Create"

### Security Rules (for testing - update for production):

```firebase
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Allow users to read/write their own profile
    match /users/{userId} {
      allow read: if request.auth.uid == userId;
      allow write: if request.auth.uid == userId;
    }
    
    // Allow anyone to read events
    match /events/{eventId} {
      allow read: if true;
      // Only creator can write
      allow write: if request.auth.uid == resource.data.userId;
      allow create: if request.auth.uid != null;
      allow delete: if request.auth.uid == resource.data.userId;
    }
  }
}
```

## Step 5: Enable Cloud Storage

1. Go to **Storage**
2. Click **"Get started"**
3. Choose region (same as Firestore)
4. Select **"Start in test mode"**
5. Click "Done"

### Storage Rules (for testing):

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

## Step 6: Get Firebase Configuration

1. Go to **Project Settings** (gear icon)
2. Under "Your apps", click your app
3. Copy the configuration values

### For Android (from google-services.json):
- Already handled by google-services.json

### For iOS (from GoogleService-Info.plist):
- Already handled by GoogleService-Info.plist

### For Web/Other platforms:
- Copy these values and update `lib/firebase_options.dart`

## Step 7: Update firebase_options.dart

Replace the placeholders in `lib/firebase_options.dart` with your actual Firebase configuration:

```dart
// From your Firebase Console Project Settings
static const FirebaseOptions web = FirebaseOptions(
  apiKey: 'AIza...',  // Web API Key
  appId: '1:123...:web:abc...',  // Web App ID
  messagingSenderId: '123...',  // Sender ID
  projectId: 'your-project-id',  // Project ID
  authDomain: 'your-project-id.firebaseapp.com',
  storageBucket: 'your-project-id.appspot.com',
);
```

## Step 8: Install Flutter Dependencies

Run in terminal:

```bash
flutter pub get
```

## Step 9: Test Firebase Connection

Run the app:

```bash
flutter run
```

If you see errors:
- Check that Firebase is enabled in Console
- Verify google-services.json is in correct location
- Check that pubspec.yaml has all Firebase packages
- For iOS: Run `flutter clean` and `flutter pub get`

## Testing Checklist

- [ ] App starts without Firebase errors
- [ ] Can register with email/password
- [ ] User profile created in Firestore
- [ ] Can login with created account
- [ ] Can create events
- [ ] Events appear in Firestore
- [ ] Can browse and search events
- [ ] Can view event details
- [ ] Can attend events
- [ ] Can view user profile with created events count

## Production Deployment

Before deploying to production:

1. **Update Firebase Security Rules** (see above)
2. **Enable Email Verification** in Authentication settings
3. **Add your domain to authorized domains**
4. **Set up proper error handling** in app
5. **Test with production database**
6. **Enable multi-factor authentication** (optional)
7. **Set up Firebase Monitoring and Logging**

## Useful Firebase CLI Commands

```bash
# Install Firebase CLI
npm install -g firebase-tools

# Login to Firebase
firebase login

# Deploy Firestore rules
firebase deploy --only firestore:rules

# Deploy storage rules
firebase deploy --only storage

# View logs
firebase functions:log

# Start emulator
firebase emulators:start
```

## Common Issues

### Issue: "google-services.json not found"
**Solution**: Make sure file is in `android/app/` directory (not `android/`)

### Issue: "Firestore permission denied"
**Solution**: Check security rules allow the operation

### Issue: "Firebase not initialized"
**Solution**: Make sure `Firebase.initializeApp()` is called before `runApp()`

### Issue: "Images not uploading"
**Solution**: Check Storage is enabled and rules allow uploads
