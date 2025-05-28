import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

class Navbar extends StatelessWidget {
  // final String title;

  const Navbar({
    // required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // int index = 3;
    return FBottomNavigationBar(
      // index: index,
      // onChange: (index) => setState(() => this.index = index),
      children: const [
        FBottomNavigationBarItem(
          icon: Icon(FIcons.house),
          label: Text('Home'),
        ),
        FBottomNavigationBarItem(
          icon: Icon(FIcons.layoutGrid),
          label: Text('Categories'),
        ),
        FBottomNavigationBarItem(
          icon: Icon(FIcons.search),
          label: Text('Search'),
        ),
        FBottomNavigationBarItem(
          icon: Icon(FIcons.settings),
          label: Text('Settings'),
        ),
      ],
    );
  }
}
