import 'package:flutter/material.dart';
import '../widgets/custom_footer.dart';
import '../constants/app_colors.dart';

class CreateEventPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.event, color: AppColors.emerald600),
            SizedBox(width: 8),
            Text('Create Event', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.gray800)),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.gray800),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 24), 
                    child: Column(
                      children: [
                        Text(
                          'Create Your Event', 
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.gray800)
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Fill out the form below to create and publish your event.', 
                          style: TextStyle(color: AppColors.gray600, fontSize: 14),
                          textAlign: TextAlign.center,
                        ),
                      ]
                    )
                  ),
                  Card(
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Basic Information', 
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.gray800)
                          ),
                          SizedBox(height: 16),
                          TextField(
                            decoration: InputDecoration(
                              labelText: 'Event Title', 
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))
                            )
                          ),
                          SizedBox(height: 16),
                          DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              labelText: 'Category', 
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))
                            ), 
                            items: ['Workshop', 'Conference', 'Seminar', 'Social', 'Community'].map((String category) => DropdownMenuItem(value: category, child: Text(category))).toList(), 
                            onChanged: (value) {}
                          ),
                          SizedBox(height: 16),
                          TextField(
                            decoration: InputDecoration(
                              labelText: 'Description', 
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))
                            ), 
                            maxLines: 3
                          ),
                          SizedBox(height: 16),
                          TextField(
                            decoration: InputDecoration(
                              labelText: 'Date', 
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)), 
                              suffixIcon: Icon(Icons.calendar_today)
                            ), 
                            readOnly: true, 
                            onTap: () {}
                          ),
                          SizedBox(height: 16),
                          TextField(
                            decoration: InputDecoration(
                              labelText: 'Time', 
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)), 
                              suffixIcon: Icon(Icons.access_time)
                            ), 
                            readOnly: true, 
                            onTap: () {}
                          ),
                          SizedBox(height: 24),
                          Text(
                            'Event Media', 
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.gray800)
                          ),
                          SizedBox(height: 16),
                          Container(
                            height: 150, 
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.gray300), 
                              borderRadius: BorderRadius.circular(8)
                            ), 
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center, 
                              children: [
                                Icon(Icons.image, size: 40, color: AppColors.gray400), 
                                SizedBox(height: 12), 
                                Text(
                                  'Drag and drop your event image here', 
                                  style: TextStyle(color: AppColors.gray600, fontSize: 12)
                                ), 
                                SizedBox(height: 8), 
                                ElevatedButton(
                                  onPressed: () {}, 
                                  child: Text('Select Image'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.emerald600,
                                    foregroundColor: Colors.white,
                                  ),
                                )
                              ]
                            )
                          ),
                          SizedBox(height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end, 
                            children: [
                              OutlinedButton(
                                onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Draft saved'))
                                ), 
                                child: Text('Save Draft')
                              ),
                              SizedBox(width: 12),
                              ElevatedButton(
                                onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Event published!'))
                                ), 
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.emerald600, 
                                  foregroundColor: Colors.white
                                ), 
                                child: Text('Publish Event')
                              ),
                            ]
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
}