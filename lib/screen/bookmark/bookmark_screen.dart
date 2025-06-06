import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tourism_app/provider/bookmark/local_database_provider.dart';
import 'package:tourism_app/screen/home/tourism_card_widget.dart';
import 'package:tourism_app/static/navigation_route.dart';

class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({super.key});

  @override
  State<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (mounted) {
        context.read<LocalDatabaseProvider>().loadAllTourism();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Bookmark List")),
      body: Consumer<LocalDatabaseProvider>(
        builder: (context, value, child) {
          final bookmarkList = value.tourismList ?? [];
          return switch (bookmarkList.isNotEmpty) {
            true => ListView.builder(
              itemCount: bookmarkList.length,
              itemBuilder: (context, index) {
                final tourism = bookmarkList[index];
                return TourismCard(
                  tourism: tourism,
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      NavigationRoute.detailRoute.name,
                      arguments: tourism.id,
                    );
                  },
                );
              },
            ),
            _ => const Center(
              child: Text("No Bookmark", style: TextStyle(fontSize: 20)),
            ),
          };
        },
      ),
    );
  }
}
