import 'package:flutter/material.dart';
import '../widgets/custom_navbar.dart';
import '../widgets/custom_footer.dart';
import '../widgets/stats_card.dart';
import '../constants/app_colors.dart';
import 'create_event_page.dart';

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
                      Text(
                        'Organizer Dashboard', 
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
                  GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 1.2,
                    ),
                    itemCount: 4,
                    itemBuilder: (context, index) => _buildStatsCard(index),
                  ),
                  SizedBox(height: 24),
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
                              Wrap(
                                spacing: 8,
                                children: [
                                  OutlinedButton(
                                    onPressed: () {}, 
                                    child: Text('Upcoming'),
                                    style: OutlinedButton.styleFrom(padding: EdgeInsets.symmetric(horizontal: 12)),
                                  ),
                                  OutlinedButton(
                                    onPressed: () {}, 
                                    child: Text('Past'),
                                    style: OutlinedButton.styleFrom(padding: EdgeInsets.symmetric(horizontal: 12)),
                                  ),
                                  OutlinedButton(
                                    onPressed: () {}, 
                                    child: Text('Drafts'),
                                    style: OutlinedButton.styleFrom(padding: EdgeInsets.symmetric(horizontal: 12)),
                                  ),
                                ],
                              ),
                            ]
                          ),
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
      {
        'title': 'Total Events', 
        'value': '12', 
        'subtitle': '+2 from last month', 
        'icon': Icons.calendar_today, 
        'color': AppColors.blue600
      },
      {
        'title': 'Upcoming Events', 
        'value': '4', 
        'subtitle': 'Next: Tomorrow', 
        'icon': Icons.access_time, 
        'color': AppColors.emerald600
      },
      {
        'title': 'Total Attendees', 
        'value': '327', 
        'subtitle': '+15% from last month', 
        'icon': Icons.people, 
        'color': AppColors.purple600
      },
      {
        'title': 'Avg. Attendance', 
        'value': '72%', 
        'subtitle': '+8% from last month', 
        'icon': Icons.trending_up, 
        'color': AppColors.yellow600
      },
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
      {
        'title': 'Tech Entrepreneurship Workshop', 
        'organizer': 'Innovation Hub', 
        'date': 'Nov 20, 2025', 
        'time': '2:00 PM', 
        'attendees': '45', 
        'status': 'Upcoming', 
        'statusColor': Colors.green
      },
      {
        'title': 'Career Fair 2025', 
        'organizer': 'University', 
        'date': 'Nov 5, 2025', 
        'time': '9:00 AM', 
        'attendees': '122', 
        'status': 'Completed', 
        'statusColor': Colors.blue
      },
    ];

    return events.map((event) {
      return Container(
        margin: EdgeInsets.only(bottom: 12),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.gray200), 
          borderRadius: BorderRadius.circular(8)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 16, 
                  backgroundColor: AppColors.gray200, 
                  child: Icon(Icons.event, size: 16)
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        event['title'] as String, 
                        style: TextStyle(fontWeight: FontWeight.w600)
                      ),
                      Text(
                        event['organizer'] as String, 
                        style: TextStyle(color: AppColors.gray600, fontSize: 12)
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
                  '${event['date']} • ${event['time']}', 
                  style: TextStyle(fontSize: 12, color: AppColors.gray600)
                ),
                Text(
                  '${event['attendees']} attendees', 
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4), 
                  decoration: BoxDecoration(
                    color: (event['statusColor'] as Color).withOpacity(0.1), 
                    borderRadius: BorderRadius.circular(12)
                  ), 
                  child: Text(
                    event['status'] as String, 
                    style: TextStyle(
                      color: event['statusColor'] as Color, 
                      fontSize: 10, 
                      fontWeight: FontWeight.w500
                    )
                  )
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () {}, 
                    child: Text('Edit', style: TextStyle(color: AppColors.emerald600))
                  ),
                ),
                Expanded(
                  child: TextButton(
                    onPressed: () {}, 
                    child: Text('View', style: TextStyle(color: AppColors.gray600))
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }).toList();
  }
}