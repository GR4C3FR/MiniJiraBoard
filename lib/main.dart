// ==============================================================================
// MAIN.DART - The starting point of our Flutter app
// ==============================================================================
// This file is like the "front door" of your app. Everything starts here!

import 'package:flutter/material.dart';  // Import Flutter's UI toolkit
import 'screens/task_board.dart';         // Import our TaskBoard screen

// main() - This is THE entry point. Flutter runs this function first!
void main() {
  runApp(const MyApp());  // Tell Flutter to run our app
}

// MyApp - The root widget of our entire application
// StatelessWidget = A widget that doesn't change over time
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // build() - This method tells Flutter what to show on screen
  @override
  Widget build(BuildContext context) {
    // MaterialApp - Sets up the basic app structure
    return MaterialApp(
      title: 'MiniJira Board',                    // App name (shows in task switcher)
      debugShowCheckedModeBanner: false,          // Removes the "DEBUG" banner
      
      // Theme - Controls colors and styling throughout the app
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),  // Blue color scheme
        useMaterial3: true,                       // Use the latest Material Design
      ),
      
      // home - The first screen users see when they open the app
      home: const TaskBoard(),  // Start with TaskBoard (Screen A)
    );
  }
}
