import 'package:flutter/material.dart';
import 'package:flutter_application_firebase/pages/home_page.dart';
import 'package:flutter_application_firebase/pages/calendar_page.dart';
import 'package:flutter_application_firebase/pages/settings_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TEST"),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (value) => setState(() {
          selectedIndex = value;
        }),
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.home),
            label: "Home",
            selectedIcon: Icon(Icons.home,
                color: Theme.of(context).colorScheme.onSecondaryContainer),
          ),
          NavigationDestination(
            icon: const Icon(Icons.calendar_month_rounded),
            label: "Calendar",
            selectedIcon: Icon(Icons.calendar_month_rounded,
                color: Theme.of(context).colorScheme.onSecondaryContainer),
          ),
          NavigationDestination(
            icon: const Icon(Icons.settings),
            label: "Settings",
            selectedIcon: Icon(Icons.settings,
                color: Theme.of(context).colorScheme.onSecondaryContainer),
          ),
        ],
        animationDuration: const Duration(milliseconds: 500),
      ),
      body: Center(
          child: IndexedStack(
        index: selectedIndex,
        children: const [
          HomePage(),
          CalendarPage(),
          SettingsPage(),
        ],
      )),
    );
  }
}
