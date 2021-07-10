// Flutter imports:
import 'package:flutter/cupertino.dart';

// Project imports:
import 'package:tmdb/utils/enums.dart';

class BaseModel extends ChangeNotifier {
  ViewState _state = ViewState.initial;

  ViewState get state => _state;

  void setState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }
}
