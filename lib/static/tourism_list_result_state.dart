import 'package:tourism_app/data/model/tourism.dart';

sealed class TourismListResultState {}

class TourismListNoneState extends TourismListResultState {}

class TourismListLoadingState extends TourismListResultState {}

class TourismListErrorState extends TourismListResultState{
  final String error;

  TourismListErrorState({required this.error});
}

class TourismListLoadedState extends TourismListResultState{
  final List<Tourism> data;

  TourismListLoadedState({required this.data});
}