import 'package:flutter/material.dart';
import '../widgets/custom_footer.dart';
import '../constants/app_colors.dart';
import 'login_page.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.event, color: AppColors.emerald600),
            SizedBox(width: 8),
            Text('EventEase', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.gray800)),
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
              child: Center(
                child: Container(
                  constraints: BoxConstraints(maxWidth: 500), // Fixed this line
                  padding: EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white, 
                    borderRadius: BorderRadius.circular(12), 
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10)]
                  ),
                  child: Column(
                    children: [
                      Column(
                        children: [
                          Text(
                            'Create an account', 
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.gray800)
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Join EventEase to create and manage events', 
                            style: TextStyle(color: AppColors.gray600), 
                            textAlign: TextAlign.center
                          ),
                        ]
                      ),
                      SizedBox(height: 24),
                      Column(
                        children: [
                          TextField(
                            decoration: InputDecoration(
                              labelText: 'First Name', 
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))
                            )
                          ),
                          SizedBox(height: 16),
                          TextField(
                            decoration: InputDecoration(
                              labelText: 'Last Name', 
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))
                            )
                          ),
                          SizedBox(height: 16),
                          TextField(
                            decoration: InputDecoration(
                              labelText: 'Email', 
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))
                            )
                          ),
                          SizedBox(height: 16),
                          TextField(
                            decoration: InputDecoration(
                              labelText: 'Phone Number', 
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))
                            )
                          ),
                          SizedBox(height: 16),
                          TextField(
                            decoration: InputDecoration(
                              labelText: 'Password', 
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))
                            ), 
                            obscureText: true
                          ),
                          SizedBox(height: 16),
                          TextField(
                            decoration: InputDecoration(
                              labelText: 'Confirm Password', 
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))
                            ), 
                            obscureText: true
                          ),
                          SizedBox(height: 24),
                          SizedBox(
                            width: double.infinity, 
                            height: 48, 
                            child: ElevatedButton(
                              onPressed: () => Navigator.pushReplacementNamed(context, '/home'),
                              style: ElevatedButton.styleFrom(backgroundColor: AppColors.emerald600), 
                              child: Text(
                                'Create Account', 
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500)
                              )
                            )
                          ),
                          SizedBox(height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center, 
                            children: [
                              Text("Already have an account? ", style: TextStyle(color: AppColors.gray600)),
                              TextButton(
                                onPressed: () => Navigator.push(
                                  context, 
                                  MaterialPageRoute(builder: (context) => LoginPage())
                                ), 
                                child: Text('Login', style: TextStyle(color: AppColors.emerald600))
                              ),
                            ]
                          ),
                        ]
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