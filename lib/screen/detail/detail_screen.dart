import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tourism_app/provider/bookmark/bookmark_icon_provider.dart';
import 'package:tourism_app/provider/bookmark/tourism_detail_provider.dart';
import 'package:tourism_app/screen/detail/body_of_detail_screen_widget.dart';
import 'package:tourism_app/screen/detail/bookmark_icon_widget.dart';
import 'package:tourism_app/static/tourism_detail_result_state.dart';

class DetailScreen extends StatefulWidget {
  final int tourismId;
  const DetailScreen({super.key, required this.tourismId});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<TourismDetailProvider>().fetchTourismDetail(
        widget.tourismId,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Screen"),
        actions: [
          ChangeNotifierProvider(
            create: (context) => BookmarkIconProvider(),
            child: Consumer<TourismDetailProvider>(
              builder: (context, value, child) {
                return switch (value.resultState){
                  TourismDetailLoadedState(data: var tourism) => BookmarkIconWidget(tourism: tourism[0]),
                  _ => const SizedBox(),
                };
              },
            ),
          ),
        ],
      ),
      body: Consumer<TourismDetailProvider>(
        builder: (context, value, child) {
          return switch (value.resultState) {
            TourismDetailLoadingState() => const Center(child: CircularProgressIndicator()),
            TourismDetailErrorState(error: var error) => Center(child: Text(error)),
            TourismDetailLoadedState(data: var tourism) => BodyOfDetailScreenWidget(tourism: tourism[0]),
            _ => const SizedBox(),
          };
        },
      ),
    );
  }
}
