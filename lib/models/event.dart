class Event {
  final int id;
  final String title;
  final DateTime date;
  final String time;
  final String location;
  final String description;
  final String image;
  final int attendees;
  final String organizer;
  final String? category;
  final String? status;

  Event({
    required this.id,
    required this.title,
    required this.date,
    required this.time,
    required this.location,
    required this.description,
    required this.image,
    required this.attendees,
    required this.organizer,
    this.category,
    this.status,
  });

  Event copyWith({bool? completed}) {
    return Event(
      id: id,
      title: title,
      date: date,
      time: time,
      location: location,
      description: description,
      image: image,
      attendees: attendees,
      organizer: organizer,
      category: category,
      status: status,
    );
  }
}