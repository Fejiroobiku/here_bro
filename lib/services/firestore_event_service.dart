import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/event.dart';

class FirestoreEventService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static const String eventsCollection = 'events';
  static const String usersCollection = 'users';

  // Create a new event
  Future<String> createEvent({
    required String userId,
    required String title,
    required String category,
    required String description,
    required DateTime eventDate,
    required String location,
    required String imageUrl,
  }) async {
    try {
      final docRef = await _firestore.collection(eventsCollection).add({
        'userId': userId,
        'title': title,
        'category': category,
        'description': description,
        'eventDate': eventDate,
        'location': location,
        'imageUrl': imageUrl,
        'createdAt': Timestamp.now(),
        'updatedAt': Timestamp.now(),
        'attendees': [],
        'attendeeCount': 0,
      });
      return docRef.id;
    } catch (e) {
      throw Exception('Failed to create event: $e');
    }
  }

  // Get all events (real-time)
  Stream<List<Event>> getAllEvents() {
    try {
      return _firestore
          .collection(eventsCollection)
          .orderBy('eventDate', descending: false)
          .snapshots()
          .map((snapshot) {
        return snapshot.docs
            .map((doc) => Event.fromFirestore(doc))
            .toList();
      });
    } catch (e) {
      throw Exception('Failed to get events: $e');
    }
  }

  // Get events by category (real-time)
  Stream<List<Event>> getEventsByCategory(String category) {
    try {
      return _firestore
          .collection(eventsCollection)
          .where('category', isEqualTo: category)
          .orderBy('eventDate', descending: false)
          .snapshots()
          .map((snapshot) {
        return snapshot.docs
            .map((doc) => Event.fromFirestore(doc))
            .toList();
      });
    } catch (e) {
      throw Exception('Failed to get events by category: $e');
    }
  }

  // Search events by title
  Stream<List<Event>> searchEvents(String query) {
    try {
      if (query.isEmpty) {
        return getAllEvents();
      }
      
      // Firestore doesn't support full-text search, so we query and filter in code
      return _firestore
          .collection(eventsCollection)
          .snapshots()
          .map((snapshot) {
        return snapshot.docs
            .map((doc) => Event.fromFirestore(doc))
            .where((event) =>
                event.title.toLowerCase().contains(query.toLowerCase()) ||
                event.description.toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    } catch (e) {
      throw Exception('Failed to search events: $e');
    }
  }

  // Get user's created events (real-time)
  Stream<List<Event>> getUserCreatedEvents(String userId) {
    try {
      return _firestore
          .collection(eventsCollection)
          .where('userId', isEqualTo: userId)
          .orderBy('eventDate', descending: false)
          .snapshots()
          .map((snapshot) {
        return snapshot.docs
            .map((doc) => Event.fromFirestore(doc))
            .toList();
      });
    } catch (e) {
      throw Exception('Failed to get user events: $e');
    }
  }

  // Get event by ID
  Future<Event?> getEventById(String eventId) async {
    try {
      final doc = await _firestore
          .collection(eventsCollection)
          .doc(eventId)
          .get();
      
      if (doc.exists) {
        return Event.fromFirestore(doc);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to get event: $e');
    }
  }

  // Update event
  Future<void> updateEvent({
    required String eventId,
    required String title,
    required String category,
    required String description,
    required DateTime eventDate,
    required String location,
    required String imageUrl,
  }) async {
    try {
      await _firestore.collection(eventsCollection).doc(eventId).update({
        'title': title,
        'category': category,
        'description': description,
        'eventDate': eventDate,
        'location': location,
        'imageUrl': imageUrl,
        'updatedAt': Timestamp.now(),
      });
    } catch (e) {
      throw Exception('Failed to update event: $e');
    }
  }

  // Delete event
  Future<void> deleteEvent(String eventId) async {
    try {
      await _firestore.collection(eventsCollection).doc(eventId).delete();
    } catch (e) {
      throw Exception('Failed to delete event: $e');
    }
  }

  // Add attendee to event
  Future<void> addAttendee({
    required String eventId,
    required String userId,
    required String userName,
  }) async {
    try {
      await _firestore.collection(eventsCollection).doc(eventId).update({
        'attendees': FieldValue.arrayUnion([
          {'userId': userId, 'userName': userName}
        ]),
        'attendeeCount': FieldValue.increment(1),
      });
    } catch (e) {
      throw Exception('Failed to add attendee: $e');
    }
  }

  // Remove attendee from event
  Future<void> removeAttendee({
    required String eventId,
    required String userId,
  }) async {
    try {
      // First get the event to find the attendee to remove
      final doc = await _firestore
          .collection(eventsCollection)
          .doc(eventId)
          .get();
      
      final attendees = List.from(doc['attendees'] as List);
      attendees.removeWhere((a) => a['userId'] == userId);
      
      await _firestore.collection(eventsCollection).doc(eventId).update({
        'attendees': attendees,
        'attendeeCount': FieldValue.increment(-1),
      });
    } catch (e) {
      throw Exception('Failed to remove attendee: $e');
    }
  }
}
