import 'package:flutter/material.dart';
import '../widgets/custom_footer.dart';
import '../constants/app_colors.dart';

class ProfilePage extends StatelessWidget {
  final Function(int)? onNavTap;

  const ProfilePage({this.onNavTap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Header with Gradient
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.emerald600, AppColors.blue600],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              padding: EdgeInsets.fromLTRB(16, 40, 16, 32),
              child: Column(
                children: [
                  // Profile Avatar
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 48,
                      backgroundColor: AppColors.gray200,
                      child: Icon(
                        Icons.person,
                        size: 50,
                        color: AppColors.emerald600,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  // User Name
                  Text(
                    'John Doe',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8),
                  // User Email
                  Text(
                    'john.doe@example.com',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                  SizedBox(height: 4),
                  // User Phone
                  Text(
                    '+1 (555) 123-4567',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
            ),

            // Profile Information
            Container(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Account Information Section
                  Text(
                    'Account Information',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.gray800,
                    ),
                  ),
                  SizedBox(height: 16),
                  
                  // Info Card
                  Card(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        children: [
                          _buildInfoRow('First Name', 'John'),
                          Divider(),
                          _buildInfoRow('Last Name', 'Doe'),
                          Divider(),
                          _buildInfoRow('Email', 'john.doe@example.com'),
                          Divider(),
                          _buildInfoRow('Phone', '+1 (555) 123-4567'),
                          Divider(),
                          _buildInfoRow('Member Since', 'January 2024'),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 24),

                  // Statistics Section
                  Text(
                    'Your Statistics',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.gray800,
                    ),
                  ),
                  SizedBox(height: 16),

                  // Stats Grid
                  GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      _buildStatCard('Events Created', '12', AppColors.emerald600),
                      _buildStatCard('Attendees', '327', AppColors.blue600),
                      _buildStatCard('Events Attended', '8', AppColors.purple600),
                      _buildStatCard('Followers', '45', AppColors.yellow600),
                    ],
                  ),
                  SizedBox(height: 24),

                  // Action Buttons
                  Text(
                    'Account Settings',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.gray800,
                    ),
                  ),
                  SizedBox(height: 16),

                  // Settings Options
                  _buildSettingOption(Icons.edit, 'Edit Profile', () {}),
                  SizedBox(height: 12),
                  _buildSettingOption(Icons.lock, 'Change Password', () {}),
                  SizedBox(height: 12),
                  _buildSettingOption(Icons.notifications, 'Notifications', () {}),
                  SizedBox(height: 12),
                  _buildSettingOption(Icons.privacy_tip, 'Privacy Settings', () {}),
                  SizedBox(height: 24),

                  // Logout Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red.shade600,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: Text(
                        'Logout',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ),

            CustomFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: AppColors.gray600,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            color: AppColors.gray800,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, Color color) {
    return Card(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            colors: [color.withOpacity(0.1), color.withOpacity(0.05)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: AppColors.gray600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingOption(IconData icon, String title, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.gray200),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(icon, color: AppColors.emerald600, size: 24),
            SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.gray800,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Icon(Icons.chevron_right, color: AppColors.gray400, size: 20),
          ],
        ),
      ),
    );
  }
}
