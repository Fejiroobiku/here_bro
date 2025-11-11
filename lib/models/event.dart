import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  final String? id; // Firestore document ID
  final String title;
  final DateTime date;
  final String? time; // Optional, can be extracted from date
  final String location;
  final String description;
  final String image;
  final int attendees;
  final String organizer; // User ID of event creator
  final String? category;
  final String? status;
  final String? userId; // Firestore user ID
  final DateTime? createdAt;
  final List<dynamic>? attendeesList;

  Event({
    this.id,
    required this.title,
    required this.date,
    this.time,
    required this.location,
    required this.description,
    required this.image,
    required this.attendees,
    required this.organizer,
    this.category,
    this.status,
    this.userId,
    this.createdAt,
    this.attendeesList,
  });

  // Create Event from Firestore DocumentSnapshot
  factory Event.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    
    DateTime eventDate = DateTime.now();
    if (data['eventDate'] != null) {
      if (data['eventDate'] is Timestamp) {
        eventDate = (data['eventDate'] as Timestamp).toDate();
      } else if (data['eventDate'] is DateTime) {
        eventDate = data['eventDate'] as DateTime;
      }
    }

    DateTime? createdAtDate;
    if (data['createdAt'] != null) {
      if (data['createdAt'] is Timestamp) {
        createdAtDate = (data['createdAt'] as Timestamp).toDate();
      } else if (data['createdAt'] is DateTime) {
        createdAtDate = data['createdAt'] as DateTime;
      }
    }

    return Event(
      id: doc.id,
      title: data['title'] ?? '',
      date: eventDate,
      time: eventDate.toString().split(' ')[1].substring(0, 5), // HH:mm format
      location: data['location'] ?? '',
      description: data['description'] ?? '',
      image: data['imageUrl'] ?? '',
      attendees: data['attendeeCount'] ?? 0,
      organizer: data['userId'] ?? '',
      category: data['category'],
      status: data['status'],
      userId: data['userId'],
      createdAt: createdAtDate,
      attendeesList: data['attendees'],
    );
  }

  // Convert Event to Map for Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'eventDate': date,
      'location': location,
      'description': description,
      'imageUrl': image,
      'userId': userId,
      'category': category,
      'status': status,
      'attendeeCount': attendees,
      'createdAt': createdAt ?? Timestamp.now(),
      'updatedAt': Timestamp.now(),
    };
  }

  Event copyWith({
    String? id,
    String? title,
    DateTime? date,
    String? time,
    String? location,
    String? description,
    String? image,
    int? attendees,
    String? organizer,
    String? category,
    String? status,
    String? userId,
    DateTime? createdAt,
    List<dynamic>? attendeesList,
  }) {
    return Event(
      id: id ?? this.id,
      title: title ?? this.title,
      date: date ?? this.date,
      time: time ?? this.time,
      location: location ?? this.location,
      description: description ?? this.description,
      image: image ?? this.image,
      attendees: attendees ?? this.attendees,
      organizer: organizer ?? this.organizer,
      category: category ?? this.category,
      status: status ?? this.status,
      userId: userId ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
      attendeesList: attendeesList ?? this.attendeesList,
    );
  }
}