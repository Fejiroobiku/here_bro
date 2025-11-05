import 'package:flutter/material.dart';
import '../widgets/custom_navbar.dart';
import '../widgets/custom_footer.dart';
import '../constants/app_colors.dart';
import 'dashboard_page.dart';
import 'register_page.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomNavbar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              child: Center(
                child: Container(
                  constraints: BoxConstraints(maxWidth: 400), // Fixed this line
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
                            'Welcome back', 
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.gray800)
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Login to your EventEase account', 
                            style: TextStyle(color: AppColors.gray600)
                          ),
                        ]
                      ),
                      SizedBox(height: 24),
                      Column(
                        children: [
                          TextField(
                            decoration: InputDecoration(
                              labelText: 'Email or Phone', 
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
                          SizedBox(height: 24),
                          SizedBox(
                            width: double.infinity, 
                            height: 48, 
                            child: ElevatedButton(
                              onPressed: () => Navigator.push(
                                context, 
                                MaterialPageRoute(builder: (context) => DashboardPage())
                              ), 
                              style: ElevatedButton.styleFrom(backgroundColor: AppColors.emerald600), 
                              child: Text('Login', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500))
                            )
                          ),
                          SizedBox(height: 24),
                          Row(
                            children: [
                              Expanded(child: Divider()), 
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16), 
                                child: Text('or')
                              ), 
                              Expanded(child: Divider())
                            ]
                          ),
                          SizedBox(height: 24),
                          Row(
                            children: [
                              Expanded(
                                child: OutlinedButton.icon(
                                  onPressed: () {}, 
                                  icon: Icon(Icons.facebook, color: AppColors.blue600), 
                                  label: Text('Facebook')
                                )
                              ),
                              SizedBox(width: 16),
                              Expanded(
                                child: OutlinedButton.icon(
                                  onPressed: () {}, 
                                  icon: Icon(Icons.g_mobiledata, color: Colors.red), 
                                  label: Text('Google')
                                )
                              ),
                            ]
                          ),
                          SizedBox(height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center, 
                            children: [
                              Text("Don't have an account? ", style: TextStyle(color: AppColors.gray600)),
                              TextButton(
                                onPressed: () => Navigator.push(
                                  context, 
                                  MaterialPageRoute(builder: (context) => RegisterPage())
                                ), 
                                child: Text('Register', style: TextStyle(color: AppColors.emerald600))
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