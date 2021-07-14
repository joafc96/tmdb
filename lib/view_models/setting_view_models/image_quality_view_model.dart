import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:tmdb/utils/enums.dart';
import 'package:tmdb/utils/settings_utils/image_quality_utils.dart';
import 'package:flutter/material.dart';
import 'package:tmdb/utils/tmdb_configs.dart';
import 'package:tmdb/utils/urls.dart';

class ImageQualityViewModel with ChangeNotifier {
  ImageQualityViewModel({ImageQualitySetting imageQualitySetting}) {
    setImageQuality(imageQualitySetting);
  }

  String _curImageQuality = URLS.imageBaseUrl + PosterSizes.w342;

  ImageQualitySetting _curImageQualitySetting =
      ImageQualitySetting(imageQualityOptions.medium);

  String get curImageQuality => _curImageQuality;

  ImageQualitySetting get curImageQualitySetting => _curImageQualitySetting;

  void setImageQuality(ImageQualitySetting imageQualitySetting) {
    _curImageQuality = imageQualitySetting.getImageQuality();
    _curImageQualitySetting = imageQualitySetting;
    DefaultCacheManager().emptyCache();
    notifyListeners();
  }

}
