import 'package:flutter/material.dart';
import 'package:flutter_unicode_task/screens/tabs_switcher_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xff090025),
          brightness: Brightness.dark,
          onBackground: const Color.fromARGB(255, 146, 151, 158),
        ),
      ),
      home: const TabSwitcherScreen(),
    );
  }
}
