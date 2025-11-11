import 'package:flutter/material.dart';
import '../widgets/custom_footer.dart';
import '../widgets/event_card.dart';
import '../services/event_service.dart';
import '../constants/app_colors.dart';
import 'events_page.dart';
import 'create_event_page.dart';

class HomePage extends StatelessWidget {
  final Function(int)? onNavTap;

  const HomePage({this.onNavTap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                padding: EdgeInsets.all(24),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12), 
                  color: Colors.black.withOpacity(0.1)
                ),
                child: Column(
                  children: [
                    Text(
                      'Create & Discover Amazing Events', 
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white), 
                      textAlign: TextAlign.center
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Simple event management for universities, NGOs, and community groups.', 
                      style: TextStyle(fontSize: 16, color: Colors.white), 
                      textAlign: TextAlign.center
                    ),
                    SizedBox(height: 24),
                    Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CreateEventPage())), 
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white, 
                              foregroundColor: AppColors.emerald600, 
                              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12)
                            ), 
                            child: Text('Create Event', style: TextStyle(fontWeight: FontWeight.w600))
                          ),
                        ),
                        SizedBox(height: 12),
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton(
                            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => EventsPage())), 
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.white, 
                              side: BorderSide(color: Colors.white), 
                              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12)
                            ), 
                            child: Text('Browse Events', style: TextStyle(fontWeight: FontWeight.w600))
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 32),

            // Events Section
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Upcoming Events', 
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.gray800)
                      ),
                      TextButton(
                        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => EventsPage())),
                        child: Row(
                          children: [
                            Text('View all', style: TextStyle(color: AppColors.emerald600)), 
                            SizedBox(width: 4), 
                            Icon(Icons.chevron_right, size: 16, color: AppColors.emerald600)
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: EventService.mockEvents.length,
                    itemBuilder: (context, index) => EventCard(event: EventService.mockEvents[index]),
                  ),
                ],
              ),
            ),
            SizedBox(height: 32),
            CustomFooter(),
          ],
        ),
      ),
    );
  }
}