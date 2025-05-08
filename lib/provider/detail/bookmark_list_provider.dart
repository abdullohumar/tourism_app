import 'package:flutter/widgets.dart';
import 'package:tourism_app/model/tourism.dart';

class BookmarkListProvider extends ChangeNotifier{
  final List<Tourism> _bookMarkList = [];

  List<Tourism> get bookMarkList => _bookMarkList;

  void addBookmark(Tourism tourism) {
    _bookMarkList.add(tourism);
    notifyListeners();
  }

  void removeBookmark(Tourism tourism) {
    _bookMarkList.removeWhere((element) => element.id == tourism.id);
    notifyListeners();
  }

  bool checkItemBookmark(Tourism tourism) {
    final tourismInList = _bookMarkList.where((element) => element.id == tourism.id).toList();
    return tourismInList.isNotEmpty;
  }
}