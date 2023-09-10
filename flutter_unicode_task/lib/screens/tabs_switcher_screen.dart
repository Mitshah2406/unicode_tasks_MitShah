import 'package:flutter/material.dart';
import 'package:flutter_unicode_task/screens/contacts_screen.dart';
import 'package:flutter_unicode_task/screens/home_screen.dart';
import 'package:flutter_unicode_task/screens/weather_screen.dart';

class TabSwitcherScreen extends StatelessWidget {
  const TabSwitcherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Unicode"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => const HomeScreen(),
                  ),
                );
              },
              child: const Text("Profile Task"),
            ),
            const SizedBox(
              height: 24,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => const ContactsPage(),
                  ),
                );
              },
              child: const Text("Contact Task"),
            ),
            const SizedBox(
              height: 24,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => const WeatherScreen(),
                  ),
                );
              },
              child: const Text("Weather API Task"),
            ),
          ],
        ),
      ),
    );
  }
}
