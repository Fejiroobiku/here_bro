import 'package:flutter/material.dart';
import '../widgets/custom_footer.dart';
import '../widgets/event_card.dart';
import '../services/firestore_event_service.dart';
import '../constants/app_colors.dart';

class EventsPage extends StatefulWidget {
  final Function(int)? onNavTap;

  const EventsPage({this.onNavTap});

  @override
  _EventsPageState createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  final TextEditingController _searchController = TextEditingController();
  final _eventService = FirestoreEventService();
  String _selectedCategory = 'All';
  
  final List<String> _categories = ['All', 'Business', 'Sports', 'Music', 'Art', 'Technology', 'Community'];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Stream getFilteredEvents() {
    if (_searchController.text.isNotEmpty) {
      return _eventService.searchEvents(_searchController.text);
    } else if (_selectedCategory != 'All') {
      return _eventService.getEventsByCategory(_selectedCategory);
    } else {
      return _eventService.getAllEvents();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Browse Events', 
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.gray800)
                  ),
                  SizedBox(height: 16),
                  
                  // Search and Filter
                  Column(
                    children: [
                      // Search TextField
                      TextField(
                        controller: _searchController,
                        onChanged: (value) => setState(() {}),
                        decoration: InputDecoration(
                          hintText: 'Search events...',
                          prefixIcon: Icon(Icons.search, color: AppColors.gray400),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: AppColors.gray300),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: AppColors.gray300),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: AppColors.emerald600, width: 2),
                          ),
                          contentPadding: EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                      SizedBox(height: 12),
                      
                      // Category Filter
                      DropdownButtonFormField<String>(
                        value: _selectedCategory,
                        onChanged: (value) => setState(() => _selectedCategory = value!),
                        decoration: InputDecoration(
                          labelText: 'Category',
                          prefixIcon: Icon(Icons.filter_list, color: AppColors.emerald600),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: AppColors.gray300),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: AppColors.gray300),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: AppColors.emerald600, width: 2),
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        ),
                        items: _categories.map((String category) {
                          return DropdownMenuItem(
                            value: category, 
                            child: Text(category)
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: 24),
                  
                  // Real-time Filtered Events Stream
                  StreamBuilder(
                    stream: getFilteredEvents(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: Padding(
                            padding: EdgeInsets.all(24),
                            child: CircularProgressIndicator(color: AppColors.emerald600),
                          ),
                        );
                      }

                      if (snapshot.hasError) {
                        return Container(
                          padding: EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: Colors.red.shade50,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.red.shade200),
                          ),
                          child: Column(
                            children: [
                              Icon(Icons.error_outline, color: Colors.red.shade700, size: 40),
                              SizedBox(height: 12),
                              Text(
                                'Failed to load events',
                                style: TextStyle(color: Colors.red.shade700, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        );
                      }

                      if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Container(
                          padding: EdgeInsets.all(32),
                          child: Column(
                            children: [
                              Icon(Icons.search_off, size: 64, color: AppColors.gray400),
                              SizedBox(height: 16),
                              Text(
                                'No events found',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.gray600),
                              ),
                              SizedBox(height: 8),
                              Text(
                                _searchController.text.isNotEmpty 
                                  ? 'Try a different search term'
                                  : 'Try a different category',
                                style: TextStyle(fontSize: 14, color: AppColors.gray500),
                              ),
                            ],
                          ),
                        );
                      }

                      final events = snapshot.data!;
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: events.length,
                        itemBuilder: (context, index) => EventCard(event: events[index]),
                      );
                    },
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