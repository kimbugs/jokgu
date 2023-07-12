import 'package:flutter/material.dart';
import 'package:flutter_application_firebase/pages/home_page.dart';
import 'package:flutter_application_firebase/pages/game_page.dart';
import 'package:flutter_application_firebase/pages/settings_page.dart';
import 'package:flutter_application_firebase/pages/user_page.dart';

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
            icon: const Icon(Icons.sports_soccer_rounded),
            label: "Game",
            selectedIcon: Icon(Icons.sports_soccer_rounded,
                color: Theme.of(context).colorScheme.onSecondaryContainer),
          ),
          NavigationDestination(
            icon: const Icon(Icons.account_circle_rounded),
            label: "user",
            selectedIcon: Icon(Icons.account_circle_rounded,
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
          GamePage(),
          UsersPage(),
          SettingsPage(),
        ],
      )),
    );
  }
}
