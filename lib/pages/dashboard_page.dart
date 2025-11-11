import 'package:flutter/material.dart';
import '../widgets/custom_footer.dart';
import '../widgets/stats_card.dart';
import '../constants/app_colors.dart';
import '../services/firebase_auth_service.dart';
import '../services/firestore_event_service.dart';
import '../services/user_profile_service.dart';
import 'create_event_page.dart';

class DashboardPage extends StatefulWidget {
  final Function(int)? onNavTap;

  const DashboardPage({this.onNavTap});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final _authService = FirebaseAuthService();
  final _eventService = FirestoreEventService();
  final _profileService = UserProfileService();

  @override
  Widget build(BuildContext context) {
    final currentUser = _authService.currentUser;

    return Scaffold(
      body: currentUser == null
          ? Center(
              child: Text('Please login to view dashboard'),
            )
          : SingleChildScrollView(
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
                            Text(
                              'Dashboard', 
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.gray800)
                            ),
                            ElevatedButton.icon(
                              onPressed: () => Navigator.push(
                                context, 
                                MaterialPageRoute(builder: (context) => CreateEventPage())
                              ),
                              icon: Icon(Icons.add, size: 20),
                              label: Text('Create Event'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.emerald600, 
                                foregroundColor: Colors.white, 
                                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12)
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 24),

                        // User Stats - Real-time from Firestore
                        StreamBuilder<Map<String, dynamic>?>(
                          stream: _profileService.getUserProfileStream(currentUser.uid),
                          builder: (context, profileSnapshot) {
                            if (!profileSnapshot.hasData) {
                              return Container(
                                height: 200,
                                child: Center(
                                  child: CircularProgressIndicator(color: AppColors.emerald600),
                                ),
                              );
                            }

                            final profile = profileSnapshot.data;
                            final createdEventsCount = profile?['createdEventsCount'] ?? 0;
                            final attendingCount = profile?['attendingEvents']?.length ?? 0;

                            return GridView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 12,
                                childAspectRatio: 1.2,
                              ),
                              itemCount: 4,
                              itemBuilder: (context, index) => _buildStatsCard(
                                index,
                                createdEventsCount,
                                attendingCount,
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 24),

                        // Your Events Section - Real-time from Firestore
                        Card(
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween, 
                                  children: [
                                    Text(
                                      'Your Events', 
                                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.gray800)
                                    ),
                                  ]
                                ),
                                SizedBox(height: 16),
                                StreamBuilder(
                                  stream: _eventService.getUserCreatedEvents(currentUser.uid),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState == ConnectionState.waiting) {
                                      return Center(
                                        child: CircularProgressIndicator(color: AppColors.emerald600),
                                      );
                                    }

                                    if (snapshot.hasError) {
                                      return Text('Error: ${snapshot.error}');
                                    }

                                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                                      return Container(
                                        padding: EdgeInsets.all(32),
                                        child: Column(
                                          children: [
                                            Icon(Icons.event_note, size: 48, color: AppColors.gray400),
                                            SizedBox(height: 12),
                                            Text(
                                              'No events created yet',
                                              style: TextStyle(color: AppColors.gray600),
                                            ),
                                          ],
                                        ),
                                      );
                                    }

                                    final events = snapshot.data!;
                                    return Column(
                                      children: events.map((event) => _buildEventItem(event)).toList(),
                                    );
                                  },
                                ),
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

  Widget _buildStatsCard(int index, int createdCount, int attendingCount) {
    final stats = [
      {
        'title': 'Events Created',
        'value': createdCount.toString(),
        'subtitle': 'Total events created',
        'icon': Icons.calendar_today,
        'color': AppColors.blue600,
      },
      {
        'title': 'Attending',
        'value': attendingCount.toString(),
        'subtitle': 'Events you joined',
        'icon': Icons.check_circle,
        'color': AppColors.emerald600,
      },
      {
        'title': 'Total Attendees',
        'value': '0',
        'subtitle': 'Across all events',
        'icon': Icons.people,
        'color': AppColors.purple600,
      },
      {
        'title': 'This Month',
        'value': '0',
        'subtitle': 'Events created',
        'icon': Icons.trending_up,
        'color': AppColors.yellow600,
      },
    ];
    
    if (index >= stats.length) return SizedBox();
    
    final stat = stats[index];
    return StatsCard(
      title: stat['title'] as String,
      value: stat['value'] as String,
      subtitle: stat['subtitle'] as String,
      icon: stat['icon'] as IconData,
      color: stat['color'] as Color,
    );
  }

  Widget _buildEventItem(dynamic event) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.gray200),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundColor: AppColors.emerald100,
                child: Icon(Icons.event, size: 16, color: AppColors.emerald600),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event.title,
                      style: TextStyle(fontWeight: FontWeight.w600),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      event.category ?? 'Event',
                      style: TextStyle(color: AppColors.gray600, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${event.date.toString().split(' ')[0]}',
                style: TextStyle(fontSize: 12, color: AppColors.gray600),
              ),
              Text(
                '${event.attendees} attendees',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ],
      ),
    );
  }
}