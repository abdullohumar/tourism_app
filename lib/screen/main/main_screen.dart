import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tourism_app/provider/main/index_nav_provider.dart';
import 'package:tourism_app/screen/bookmark/bookmark_screen.dart';
import 'package:tourism_app/screen/home/home_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<IndexNavProvider>(builder: (context, value, child) {
        return switch (value.indexBottomNavBar) {
          1 => BookmarkScreen(),
          _ => HomeScreen(),
        };
      }),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          context.read<IndexNavProvider>().setIndexBottomNavBar = index;
        },
        currentIndex: context.watch<IndexNavProvider>().indexBottomNavBar,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
            tooltip: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: "Bookmark",
            tooltip: "Bookmark",
          ),
        ],
      ),
    );
  }
}
