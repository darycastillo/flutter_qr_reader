import 'package:flutter/cupertino.dart';

class UiProvider extends ChangeNotifier {
  int _selectedMenuOpt = 0;

  int get selectedMenuOpt {
    return _selectedMenuOpt;
  }

  set selectedMenuOpt(int opt) {
    _selectedMenuOpt = opt;
    notifyListeners();
  }
}
