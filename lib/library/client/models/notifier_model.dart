import 'package:flutter/material.dart';

class NotifierModel extends ChangeNotifier {
  void notify() {
    notifyListeners();
  }
}

class LoadingModel extends ChangeNotifier {
  bool loading = false;

  void changeLoading(bool load) {
    if (load != loading) {
      loading = load;
      notifyListeners();
    }
  }
}
