import 'package:flutter/cupertino.dart';
import 'package:tmdb/utils/enums.dart';

class GridCountSetting {
  gridCountOptions gridOption;

  GridCountSetting(this.gridOption);

  String getDisplayName(BuildContext context) {
    switch (gridOption) {
      case gridCountOptions.two:
        return "2 columns";
      case gridCountOptions.four:
        return "4 columns";
      case gridCountOptions.three:
      default:
        return "3 columns";
    }
  }

   int getGridCount() {
    switch (gridOption) {
      case gridCountOptions.two:
        return 2;
      case gridCountOptions.four:
        return 4;
      case gridCountOptions.three:
      default:
        return 3;
    }
  }

  // For saving to shared prefs
  int getIndex() {
    return gridOption.index;
  }
}
