import 'package:event_finder/main_pages/friends.dart';
import 'package:event_finder/main_pages/map.dart';
import 'package:event_finder/main_pages/messages.dart';
import 'package:event_finder/main_pages/settings.dart';
import 'package:flutter/material.dart';

class NavigationWrapper extends StatefulWidget {
  @override
  _NavigationWrapperState createState() => _NavigationWrapperState();
}

class _NavigationWrapperState extends State<NavigationWrapper> {
  int _currentIndex = 2;

  final List<Widget> _pages = [
    FriendsPage(),
    MessagesPage(),
    MapPage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blue,
        selectedItemColor: Colors.black, // Set the color of active icon and label
        unselectedItemColor: Colors.blue,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.people, color: Colors.black), // Set the icon color to white
            label: 'Friends',
            backgroundColor: Colors.lightBlue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message, color: Colors.black), // Set the icon color to white
            label: 'Messages',
            backgroundColor: Colors.lightBlue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map, color: Colors.black), // Set the icon color to white
            label: 'Map',
            backgroundColor: Colors.lightBlue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings, color: Colors.black), // Set the icon color to white
            label: 'Settings',
            backgroundColor: Colors.lightBlue,
          ),
        ],
      ),
    );
  }
}