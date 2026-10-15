import 'package:flutter/foundation.dart';

class HomeProvider extends ChangeNotifier {
  int _selectedTabIndex = 0;
  bool _isLoading = false;

  int get selectedTabIndex => _selectedTabIndex;
  bool get isLoading => _isLoading;

  void setTabIndex(int index) {
    _selectedTabIndex = index;
    notifyListeners();
  }

  Future<void> refreshHome() async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 1000));

    _isLoading = false;
    notifyListeners();
  }
}

