import 'package:flutter/material.dart';
import 'pages/login_page.dart';
import 'pages/register_page.dart';
import 'pages/create_event_page.dart';
import 'constants/app_colors.dart';
import 'widgets/main_app_shell.dart';

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
      home: LoginPage(),
      routes: {
        '/home': (context) => MainAppShell(),
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/dashboard': (context) => MainAppShell(initialTab: 2),
        '/events': (context) => MainAppShell(initialTab: 1),
        '/create-event': (context) => CreateEventPage(),
      },
    );
  }
}