import 'package:flutter/material.dart';
import 'package:ppam_responsi/pages/app/app_favourite.dart';
import 'package:ppam_responsi/pages/app/app_list.dart';
import 'package:ppam_responsi/pages/app/app_profile.dart';

class App extends StatefulWidget {
  final String email;

  const App({
    super.key,
    required this.email,
  });

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: [
        AppList(
          email: widget.email,
        ),
        AppFavourite(
          email: widget.email,
        ),
        AppProfile(email: widget.email),
      ][_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: "List",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Favorit",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profil",
          ),
        ],
      ),
    );
  }
}
