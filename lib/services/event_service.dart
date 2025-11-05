import '../models/event.dart';

class EventService {
  static final List<Event> mockEvents = [
    Event(
      id: 1,
      title: "Campus Clean-Up Day",
      date: DateTime(2023, 11, 15),
      time: "09:00",
      location: "University Main Campus",
      description: "Join us for a day of giving back to our campus! We'll be cleaning up various areas and planting new trees.",
      image: "https://picsum.photos/400/300?random=1",
      attendees: 45,
      organizer: "Green Campus Initiative",
      category: "Community",
      status: "Upcoming",
    ),
    Event(
      id: 2,
      title: "Tech Entrepreneurship Workshop",
      date: DateTime(2023, 11, 20),
      time: "14:00",
      location: "Computer Science Building, Room 101",
      description: "Learn how to turn your tech ideas into viable businesses from successful local entrepreneurs.",
      image: "https://picsum.photos/400/300?random=2",
      attendees: 32,
      organizer: "Innovation Hub",
      category: "Workshop",
      status: "Upcoming",
    ),
    Event(
      id: 3,
      title: "Community Health Fair",
      date: DateTime(2023, 11, 25),
      time: "10:00",
      location: "Community Center",
      description: "Free health screenings, consultations, and wellness workshops for the whole family.",
      image: "https://picsum.photos/400/300?random=3",
      attendees: 28,
      organizer: "Health & Wellness NGO",
      category: "Community",
      status: "Upcoming",
    ),
  ];

  static String formatDate(DateTime date) {
    final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    final weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return '${weekdays[date.weekday - 1]}, ${months[date.month - 1]} ${date.day}, ${date.year}';
  }

  static Event? getEventById(int id) {
    try {
      return mockEvents.firstWhere((event) => event.id == id);
    } catch (e) {
      return null;
    }
  }
}