import 'package:flutter/widgets.dart';
import 'package:tourism_app/data/local/local_database_service.dart';
import 'package:tourism_app/data/model/tourism.dart';

class LocalDatabaseProvider extends ChangeNotifier {
  final LocalDatabaseService _service;
  LocalDatabaseProvider(this._service);

  String _message = "";
  String get message => _message;

  List<Tourism>? _tourismList;
  List<Tourism>? get tourismList => _tourismList;

  Tourism? _tourism;
  Tourism? get tourism => _tourism;

  Future<void> saveTourism(Tourism value) async {
    try {
      final result = await _service.insertItem(value);
      final isError = result ==0;

      if(isError){
        _message = "Failed to save data";
      }else{
        _message = "Success to save data";
      }
    } catch (e) {
      _message = "Failed to save data";
    }
    notifyListeners();
  }

  Future<void> loadAllTourism() async {
    try {
      _tourismList = await _service.getAllItems();
      _tourism = null;
      _message = "Success to load data";
      notifyListeners();
    } catch (e) {
      _message = "Failed to load data";
      notifyListeners();      
    }
  }

  Future<void> loadTourismById(int id) async {
    try {
      _tourism = await _service.getItemById(id);
      _message = "Success to load data";
      notifyListeners();
    } catch (e) {
      _message = "Failed to load data";
      notifyListeners();
    }
  }

  Future<void> removeTourismById(int id) async {
    try {
      await _service.removeItem(id);
      _message = "Success to remove data";
      notifyListeners();
    } catch (e) {
      _message = "Failed to remove data";
      notifyListeners();
    }
  }

  bool checkItemBookmark(int id) {
    final isSameTourism = _tourism?.id == id;
    return isSameTourism;
  }
}
