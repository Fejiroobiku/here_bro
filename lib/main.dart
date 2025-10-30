import 'package:flutter/material.dart';

// ========== MODELS ==========
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

// ========== SERVICES ==========
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

// ========== CONSTANTS ==========
class AppColors {
  static const emerald500 = Color(0xFF10B981);
  static const emerald600 = Color(0xFF059669);
  static const emerald100 = Color(0xFFD1FAE5);
  static const gray50 = Color(0xFFF9FAFB);
  static const gray100 = Color(0xFFF3F4F6);
  static const gray200 = Color(0xFFE5E7EB);
  static const gray300 = Color(0xFFD1D5DB);
  static const gray400 = Color(0xFF9CA3AF);
  static const gray500 = Color(0xFF6B7280);
  static const gray600 = Color(0xFF4B5563);
  static const gray700 = Color(0xFF374151);
  static const gray800 = Color(0xFF1F2937);
  static const blue100 = Color(0xFFDBEAFE);
  static const blue600 = Color(0xFF2563EB);
  static const purple100 = Color(0xFFE9D5FF);
  static const purple600 = Color(0xFF9333EA);
  static const yellow100 = Color(0xFFFEF3C7);
  static const yellow600 = Color(0xFFD97706);
}

// ========== WIDGETS ==========
class CustomNavbar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          Icon(Icons.event, color: AppColors.emerald600),
          SizedBox(width: 8),
          Text('EventEase', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.gray800)),
        ],
      ),
      backgroundColor: Colors.white,
      elevation: 0,
      actions: [
        TextButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage())), child: Text('Home', style: TextStyle(color: AppColors.gray600))),
        TextButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => EventsPage())), child: Text('Browse', style: TextStyle(color: AppColors.gray600))),
        TextButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => DashboardPage())), child: Text('Dashboard', style: TextStyle(color: AppColors.gray600))),
        TextButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage())), child: Text('Login', style: TextStyle(color: AppColors.gray600))),
      ],
    );
  }
}

class CustomFooter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.gray800,
      padding: EdgeInsets.all(24),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.event, color: Colors.white, size: 24),
              SizedBox(width: 8),
              Text('EventEase', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
            ],
          ),
          SizedBox(height: 16),
          Text('Simple event management for universities, NGOs, and community groups.', style: TextStyle(color: AppColors.gray400)),
          SizedBox(height: 16),
          Text('© 2023 EventEase. All rights reserved.', style: TextStyle(color: AppColors.gray400)),
        ],
      ),
    );
  }
}

class EventCard extends StatelessWidget {
  final Event event;
  const EventCard({required this.event});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(event.image, height: 160, width: double.infinity, fit: BoxFit.cover),
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: Text(event.title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(color: AppColors.emerald100, borderRadius: BorderRadius.circular(12)),
                      child: Text('${event.attendees} attending', style: TextStyle(fontSize: 12, color: AppColors.emerald600, fontWeight: FontWeight.w500)),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(children: [Icon(Icons.calendar_today, size: 16, color: AppColors.gray600), SizedBox(width: 4), Text('${EventService.formatDate(event.date)} • ${event.time}', style: TextStyle(color: AppColors.gray600))]),
                SizedBox(height: 4),
                Row(children: [Icon(Icons.location_on, size: 16, color: AppColors.gray600), SizedBox(width: 4), Expanded(child: Text(event.location, style: TextStyle(color: AppColors.gray600)))]),
                SizedBox(height: 8),
                Text(event.description, maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(color: AppColors.gray600)),
                SizedBox(height: 12),
                GestureDetector(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => EventDetailsPage(eventId: event.id))),
                  child: Row(children: [Text('View details', style: TextStyle(color: AppColors.emerald600, fontWeight: FontWeight.w500)), SizedBox(width: 4), Icon(Icons.chevron_right, size: 16, color: AppColors.emerald600)]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class StatsCard extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;
  final IconData icon;
  final Color color;

  const StatsCard({required this.title, required this.value, required this.subtitle, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: TextStyle(color: AppColors.gray500, fontSize: 14, fontWeight: FontWeight.w500)),
                    SizedBox(height: 8),
                    Text(value, style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.gray800)),
                  ],
                ),
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                  child: Icon(icon, color: color, size: 24),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(subtitle, style: TextStyle(color: AppColors.gray500, fontSize: 14)),
          ],
        ),
      ),
    );
  }
}

// ========== PAGES ==========
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomNavbar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Hero Section
            Container(
              margin: EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: LinearGradient(colors: [AppColors.emerald600, AppColors.blue600]),
              ),
              child: Container(
                padding: EdgeInsets.all(32),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: Colors.black.withOpacity(0.1)),
                child: Column(
                  children: [
                    Text('Create & Discover Amazing Events', style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.white), textAlign: TextAlign.center),
                    SizedBox(height: 16),
                    Text('Simple event management for universities, NGOs, and community groups.', style: TextStyle(fontSize: 20, color: Colors.white), textAlign: TextAlign.center),
                    SizedBox(height: 32),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      ElevatedButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CreateEventPage())), style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: AppColors.emerald600, padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12)), child: Text('Create Event', style: TextStyle(fontWeight: FontWeight.w600))),
                      SizedBox(width: 16),
                      OutlinedButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => EventsPage())), style: OutlinedButton.styleFrom(foregroundColor: Colors.white, side: BorderSide(color: Colors.white), padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12)), child: Text('Browse Events', style: TextStyle(fontWeight: FontWeight.w600))),
                    ]),
                  ],
                ),
              ),
            ),
            SizedBox(height: 48),

            // Events Section
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Upcoming Events', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.gray800)),
                      TextButton(
                        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => EventsPage())),
                        child: Row(children: [Text('View all', style: TextStyle(color: AppColors.emerald600)), SizedBox(width: 4), Icon(Icons.chevron_right, size: 20, color: AppColors.emerald600)]),
                      ),
                    ],
                  ),
                  SizedBox(height: 24),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 16, mainAxisSpacing: 16, childAspectRatio: 0.8),
                    itemCount: EventService.mockEvents.length,
                    itemBuilder: (context, index) => EventCard(event: EventService.mockEvents[index]),
                  ),
                ],
              ),
            ),
            SizedBox(height: 48),

            // Features Section
            Container(
              padding: EdgeInsets.all(24),
              margin: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10)]),
              child: Column(
                children: [
                  Text('Why Choose EventEase?', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: AppColors.gray800), textAlign: TextAlign.center),
                  SizedBox(height: 48),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 24, mainAxisSpacing: 24, childAspectRatio: 0.9),
                    itemCount: 3,
                    itemBuilder: (context, index) => _buildFeatureItem(index),
                  ),
                ],
              ),
            ),
            SizedBox(height: 48),
            CustomFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureItem(int index) {
    final features = [
      {'icon': Icons.calendar_today, 'title': 'Easy Event Creation', 'description': 'Create events in minutes with our simple form. No technical skills needed.', 'color': AppColors.emerald600},
      {'icon': Icons.notifications, 'title': 'Smart Reminders', 'description': 'Automatic notifications to keep attendees engaged and informed.', 'color': AppColors.blue600},
      {'icon': Icons.people, 'title': 'Attendance Tracking', 'description': 'Real-time RSVP and attendance tracking for better event planning.', 'color': AppColors.purple600},
    ];

    final feature = features[index];
    Color featureColor = feature['color'] as Color;
    String featureTitle = feature['title'] as String;
    String featureDescription = feature['description'] as String;
    IconData featureIcon = feature['icon'] as IconData;

    return Container(
      padding: EdgeInsets.all(24),
      child: Column(
        children: [
          Container(
            width: 64, 
            height: 64, 
            decoration: BoxDecoration(color: featureColor.withOpacity(0.1), shape: BoxShape.circle), 
            child: Icon(featureIcon, size: 32, color: featureColor)
          ),
          SizedBox(height: 16),
          Text(featureTitle, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: AppColors.gray800), textAlign: TextAlign.center),
          SizedBox(height: 8),
          Text(featureDescription, style: TextStyle(color: AppColors.gray600), textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

class EventsPage extends StatefulWidget {
  @override
  _EventsPageState createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = 'All Categories';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomNavbar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Browse Events', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.gray800)),
                      Container(
                        width: 400,
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _searchController,
                                decoration: InputDecoration(
                                  hintText: 'Search events...',
                                  prefixIcon: Icon(Icons.search, color: AppColors.gray400),
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                                ),
                              ),
                            ),
                            SizedBox(width: 16),
                            Container(
                              width: 150,
                              child: DropdownButtonFormField<String>(
                                value: _selectedCategory,
                                decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
                                items: ['All Categories', 'University', 'Community', 'Workshop', 'Social'].map((String category) {
                                  return DropdownMenuItem(value: category, child: Text(category));
                                }).toList(),
                                onChanged: (value) => setState(() => _selectedCategory = value!),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 32),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 16, mainAxisSpacing: 16, childAspectRatio: 0.8),
                    itemCount: EventService.mockEvents.length,
                    itemBuilder: (context, index) => EventCard(event: EventService.mockEvents[index]),
                  ),
                ],
              ),
            ),
            CustomFooter(),
          ],
        ),
      ),
    );
  }
}

class EventDetailsPage extends StatelessWidget {
  final int eventId;
  const EventDetailsPage({required this.eventId});

  @override
  Widget build(BuildContext context) {
    final event = EventService.getEventById(eventId) ?? EventService.mockEvents.first;
    
    return Scaffold(
      appBar: CustomNavbar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Card(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(flex: 1, child: Image.network(event.image, height: 400, fit: BoxFit.cover)),
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: EdgeInsets.all(32),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(child: Text(event.title, style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.gray800))),
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                      decoration: BoxDecoration(color: AppColors.emerald100, borderRadius: BorderRadius.circular(16)),
                                      child: Text('${event.attendees} attending', style: TextStyle(color: AppColors.emerald600, fontWeight: FontWeight.w500)),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 16),
                                Row(children: [Icon(Icons.calendar_today, size: 20, color: AppColors.gray600), SizedBox(width: 8), Text('${EventService.formatDate(event.date)} • ${event.time}', style: TextStyle(color: AppColors.gray600))]),
                                SizedBox(height: 8),
                                Row(children: [Icon(Icons.location_on, size: 20, color: AppColors.gray600), SizedBox(width: 8), Expanded(child: Text(event.location, style: TextStyle(color: AppColors.gray600)))]),
                                SizedBox(height: 24),
                                Text('About This Event', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: AppColors.gray800)),
                                SizedBox(height: 8),
                                Text(event.description, style: TextStyle(color: AppColors.gray600, height: 1.6)),
                                SizedBox(height: 32),
                                Row(
                                  children: [
                                    Expanded(
                                      child: ElevatedButton.icon(
                                        onPressed: () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('RSVP confirmed!'))),
                                        icon: Icon(Icons.check_circle, size: 20),
                                        label: Text('RSVP Now'),
                                        style: ElevatedButton.styleFrom(backgroundColor: AppColors.emerald600, foregroundColor: Colors.white, padding: EdgeInsets.symmetric(vertical: 16)),
                                      ),
                                    ),
                                    SizedBox(width: 16),
                                    Expanded(
                                      child: OutlinedButton.icon(
                                        onPressed: () {},
                                        icon: Icon(Icons.share, size: 20),
                                        label: Text('Share Event'),
                                        style: OutlinedButton.styleFrom(padding: EdgeInsets.symmetric(vertical: 16)),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            CustomFooter(),
          ],
        ),
      ),
    );
  }
}

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomNavbar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(32),
              child: Center(
                child: Container(
                  width: 400,
                  padding: EdgeInsets.all(32),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10)]),
                  child: Column(
                    children: [
                      Column(children: [
                        Text('Welcome back', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.gray800)),
                        SizedBox(height: 8),
                        Text('Login to your EventEase account', style: TextStyle(color: AppColors.gray600)),
                      ]),
                      SizedBox(height: 32),
                      Column(children: [
                        TextField(decoration: InputDecoration(labelText: 'Email or Phone', border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)))),
                        SizedBox(height: 16),
                        TextField(decoration: InputDecoration(labelText: 'Password', border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))), obscureText: true),
                        SizedBox(height: 24),
                        SizedBox(width: double.infinity, height: 48, child: ElevatedButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => DashboardPage())), style: ElevatedButton.styleFrom(backgroundColor: AppColors.emerald600), child: Text('Login', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500)))),
                        SizedBox(height: 24),
                        Row(children: [Expanded(child: Divider()), Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: Text('or')), Expanded(child: Divider())]),
                        SizedBox(height: 24),
                        Row(children: [
                          Expanded(child: OutlinedButton.icon(onPressed: () {}, icon: Icon(Icons.facebook, color: AppColors.blue600), label: Text('Facebook'))),
                          SizedBox(width: 16),
                          Expanded(child: OutlinedButton.icon(onPressed: () {}, icon: Icon(Icons.g_mobiledata, color: Colors.red), label: Text('Google'))),
                        ]),
                        SizedBox(height: 24),
                        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                          Text("Don't have an account? ", style: TextStyle(color: AppColors.gray600)),
                          TextButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage())), child: Text('Register', style: TextStyle(color: AppColors.emerald600))),
                        ]),
                      ]),
                    ],
                  ),
                ),
              ),
            ),
            CustomFooter(),
          ],
        ),
      ),
    );
  }
}

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomNavbar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(32),
              child: Center(
                child: Container(
                  width: 500,
                  padding: EdgeInsets.all(32),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10)]),
                  child: Column(
                    children: [
                      Column(children: [
                        Text('Create an account', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.gray800)),
                        SizedBox(height: 8),
                        Text('Join EventEase to create and manage events', style: TextStyle(color: AppColors.gray600), textAlign: TextAlign.center),
                      ]),
                      SizedBox(height: 32),
                      Column(children: [
                        Row(children: [
                          Expanded(child: TextField(decoration: InputDecoration(labelText: 'First Name', border: OutlineInputBorder()))),
                          SizedBox(width: 16),
                          Expanded(child: TextField(decoration: InputDecoration(labelText: 'Last Name', border: OutlineInputBorder()))),
                        ]),
                        SizedBox(height: 16),
                        TextField(decoration: InputDecoration(labelText: 'Email', border: OutlineInputBorder())),
                        SizedBox(height: 16),
                        TextField(decoration: InputDecoration(labelText: 'Phone Number', border: OutlineInputBorder())),
                        SizedBox(height: 16),
                        TextField(decoration: InputDecoration(labelText: 'Password', border: OutlineInputBorder()), obscureText: true),
                        SizedBox(height: 16),
                        TextField(decoration: InputDecoration(labelText: 'Confirm Password', border: OutlineInputBorder()), obscureText: true),
                        SizedBox(height: 24),
                        SizedBox(width: double.infinity, height: 48, child: ElevatedButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => DashboardPage())), style: ElevatedButton.styleFrom(backgroundColor: AppColors.emerald600), child: Text('Create Account', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500)))),
                        SizedBox(height: 24),
                        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                          Text("Already have an account? ", style: TextStyle(color: AppColors.gray600)),
                          TextButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage())), child: Text('Login', style: TextStyle(color: AppColors.emerald600))),
                        ]),
                      ]),
                    ],
                  ),
                ),
              ),
            ),
            CustomFooter(),
          ],
        ),
      ),
    );
  }
}

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomNavbar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Organizer Dashboard', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.gray800)),
                      ElevatedButton.icon(
                        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CreateEventPage())),
                        icon: Icon(Icons.add, size: 20),
                        label: Text('Create New Event'),
                        style: ElevatedButton.styleFrom(backgroundColor: AppColors.emerald600, foregroundColor: Colors.white, padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12)),
                      ),
                    ],
                  ),
                  SizedBox(height: 32),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, crossAxisSpacing: 16, mainAxisSpacing: 16, childAspectRatio: 1.5),
                    itemCount: 4,
                    itemBuilder: (context, index) => _buildStatsCard(index),
                  ),
                  SizedBox(height: 32),
                  Card(
                    child: Padding(
                      padding: EdgeInsets.all(24),
                      child: Column(
                        children: [
                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                            Text('Your Events', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: AppColors.gray800)),
                            Row(children: [
                              OutlinedButton(onPressed: () {}, child: Text('Upcoming')), SizedBox(width: 8),
                              OutlinedButton(onPressed: () {}, child: Text('Past')), SizedBox(width: 8),
                              OutlinedButton(onPressed: () {}, child: Text('Drafts')),
                            ]),
                          ]),
                          SizedBox(height: 16),
                          ..._buildEventItems(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            CustomFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsCard(int index) {
    final stats = [
      {'title': 'Total Events', 'value': '12', 'subtitle': '+2 from last month', 'icon': Icons.calendar_today, 'color': AppColors.blue600},
      {'title': 'Upcoming Events', 'value': '4', 'subtitle': 'Next: Tomorrow', 'icon': Icons.access_time, 'color': AppColors.emerald600},
      {'title': 'Total Attendees', 'value': '327', 'subtitle': '+15% from last month', 'icon': Icons.people, 'color': AppColors.purple600},
      {'title': 'Avg. Attendance', 'value': '72%', 'subtitle': '+8% from last month', 'icon': Icons.trending_up, 'color': AppColors.yellow600},
    ];
    final stat = stats[index];
    return StatsCard(
      title: stat['title'] as String, 
      value: stat['value'] as String, 
      subtitle: stat['subtitle'] as String, 
      icon: stat['icon'] as IconData, 
      color: stat['color'] as Color
    );
  }

  List<Widget> _buildEventItems() {
    final events = [
      {'title': 'Tech Entrepreneurship Workshop', 'organizer': 'Innovation Hub', 'date': 'Nov 20, 2023', 'time': '2:00 PM', 'attendees': '45', 'status': 'Upcoming', 'statusColor': Colors.green},
      {'title': 'Career Fair 2023', 'organizer': 'University', 'date': 'Nov 5, 2023', 'time': '9:00 AM', 'attendees': '122', 'status': 'Completed', 'statusColor': Colors.blue},
    ];

    return events.map((event) {
      return Container(
        margin: EdgeInsets.only(bottom: 16),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(border: Border.all(color: AppColors.gray200), borderRadius: BorderRadius.circular(8)),
        child: Row(children: [
          CircleAvatar(radius: 20, backgroundColor: AppColors.gray200, child: Icon(Icons.event, size: 20)),
          SizedBox(width: 12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(event['title'] as String, style: TextStyle(fontWeight: FontWeight.w600)), Text(event['organizer'] as String, style: TextStyle(color: AppColors.gray600, fontSize: 14))])),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(event['date'] as String, style: TextStyle(fontWeight: FontWeight.w500)), Text(event['time'] as String, style: TextStyle(color: AppColors.gray600, fontSize: 14))]),
          SizedBox(width: 16),
          Text(event['attendees'] as String, style: TextStyle(fontWeight: FontWeight.w500)),
          SizedBox(width: 16),
          Container(padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: (event['statusColor'] as Color).withOpacity(0.1), borderRadius: BorderRadius.circular(12)), child: Text(event['status'] as String, style: TextStyle(color: event['statusColor'] as Color, fontSize: 12, fontWeight: FontWeight.w500))),
          SizedBox(width: 16),
          Row(children: [TextButton(onPressed: () {}, child: Text('Edit', style: TextStyle(color: AppColors.emerald600))), TextButton(onPressed: () {}, child: Text('View', style: TextStyle(color: AppColors.gray600)))]),
        ]),
      );
    }).toList();
  }
}

class CreateEventPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomNavbar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(32),
              child: Center(
                child: Container(
                  width: 800,
                  child: Column(
                    children: [
                      Container(margin: EdgeInsets.only(bottom: 32), child: Column(children: [Text('Create Your Event', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: AppColors.gray800)), SizedBox(height: 8), Text('Fill out the form below to create and publish your event.', style: TextStyle(color: AppColors.gray600, fontSize: 16))])),
                      Card(
                        child: Padding(
                          padding: EdgeInsets.all(32),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Basic Information', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: AppColors.gray800)),
                              SizedBox(height: 16),
                              Row(children: [
                                Expanded(child: TextField(decoration: InputDecoration(labelText: 'Event Title', border: OutlineInputBorder()))),
                                SizedBox(width: 16),
                                Expanded(child: DropdownButtonFormField<String>(decoration: InputDecoration(labelText: 'Category', border: OutlineInputBorder()), items: ['Workshop', 'Conference', 'Seminar', 'Social', 'Community'].map((String category) => DropdownMenuItem(value: category, child: Text(category))).toList(), onChanged: (value) {})),
                              ]),
                              SizedBox(height: 16),
                              TextField(decoration: InputDecoration(labelText: 'Description', border: OutlineInputBorder()), maxLines: 4),
                              SizedBox(height: 16),
                              Row(children: [
                                Expanded(child: TextField(decoration: InputDecoration(labelText: 'Date', border: OutlineInputBorder(), suffixIcon: Icon(Icons.calendar_today)), readOnly: true, onTap: () {})),
                                SizedBox(width: 16),
                                Expanded(child: TextField(decoration: InputDecoration(labelText: 'Time', border: OutlineInputBorder(), suffixIcon: Icon(Icons.access_time)), readOnly: true, onTap: () {})),
                              ]),
                              SizedBox(height: 32),
                              Text('Event Media', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: AppColors.gray800)),
                              SizedBox(height: 16),
                              Container(
                                height: 200, 
                                decoration: BoxDecoration(
                                  border: Border.all(color: AppColors.gray300), 
                                  borderRadius: BorderRadius.circular(8)
                                ), 
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center, 
                                  children: [
                                    Icon(Icons.image, size: 48, color: AppColors.gray400), 
                                    SizedBox(height: 16), 
                                    Text('Drag and drop your event image here', style: TextStyle(color: AppColors.gray600)), 
                                    SizedBox(height: 8), 
                                    ElevatedButton(onPressed: () {}, child: Text('Select Image'))
                                  ]
                                )
                              ),
                              SizedBox(height: 32),
                              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                                OutlinedButton(onPressed: () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Draft saved'))), child: Text('Save Draft')),
                                SizedBox(width: 16),
                                ElevatedButton(onPressed: () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Event published!'))), style: ElevatedButton.styleFrom(backgroundColor: AppColors.emerald600, foregroundColor: Colors.white), child: Text('Publish Event')),
                              ]),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            CustomFooter(),
          ],
        ),
      ),
    );
  }
}

// ========== MAIN APP ==========
void main() {
  runApp(EventEaseApp());
}

class EventEaseApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EventEase',
      theme: ThemeData(
        primaryColor: AppColors.emerald600,
        scaffoldBackgroundColor: AppColors.gray50,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          titleTextStyle: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      home: HomePage(),
      routes: {
        '/home': (context) => HomePage(),
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/dashboard': (context) => DashboardPage(),
        '/events': (context) => EventsPage(),
        '/create-event': (context) => CreateEventPage(),
      },
    );
  }
}