import 'package:flutter/widgets.dart';
import 'package:tourism_app/data/api/api_service.dart';
import 'package:tourism_app/static/tourism_detail_result_state.dart';

class TourismDetailProvider extends ChangeNotifier{
    final ApiService _apiService;

  TourismDetailProvider(this._apiService);

  TourismDetailResultState _resultState = TourismDetailNoneState();

  TourismDetailResultState get resultState => _resultState;

  Future<void> fetchTourismDetail(int id) async {
    try {
        _resultState = TourismDetailLoadingState();
        notifyListeners();

        final result = await _apiService.getTourismDetail(id);
        if (result.error){
            _resultState = TourismDetailErrorState(error: result.message);
            notifyListeners();
        }else{
            _resultState = TourismDetailLoadedState(data: [result.place]);
            notifyListeners();
        }
    } on Exception catch (e) {
        _resultState = TourismDetailErrorState(error: e.toString());
        notifyListeners();
    }
  }
}