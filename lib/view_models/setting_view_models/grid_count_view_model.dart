import 'package:flutter/material.dart';
import '../../utils/enums.dart';
import '../../utils/settings_utils/grid_count_utils.dart';

class GridCountViewModel with ChangeNotifier {
  GridCountViewModel({GridCountSetting gridCountSetting}) {
    setGridCount(gridCountSetting);
  }

  int _curGridCount = 3;

  GridCountSetting _curGridCountSetting =
      GridCountSetting(gridCountOptions.three);

  int get curGridCount => _curGridCount;

  GridCountSetting get curGridCountSetting => _curGridCountSetting;

  void setGridCount(GridCountSetting gridCountSetting) {
    _curGridCount = gridCountSetting.getGridCount();
    _curGridCountSetting = gridCountSetting;
    notifyListeners();
  }

}