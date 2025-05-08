// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tourism_app/model/tourism.dart';
import 'package:tourism_app/provider/detail/bookmark_list_provider.dart';
import 'package:tourism_app/provider/main/index_nav_provider.dart';
import 'package:tourism_app/screen/detail/detail_screen.dart';
import 'package:tourism_app/screen/main/main_screen.dart';
import 'package:tourism_app/static/navigation_route.dart';
import 'package:tourism_app/style/theme/tourism_theme.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => IndexNavProvider()),
        ChangeNotifierProvider(create: (context) => BookmarkListProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: TourismTheme.lightTheme,
      darkTheme: TourismTheme.darkTheme,
      themeMode: ThemeMode.system,
      initialRoute: NavigationRoute.mainRoute.name,
      routes: {
        NavigationRoute.mainRoute.name: (context) => MainScreen(),
        NavigationRoute.detailRoute.name:
            (context) => DetailScreen(
              tourism: ModalRoute.of(context)?.settings.arguments as Tourism,
            ),
      },
    );
  }
}
