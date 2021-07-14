import 'package:flutter/material.dart';

import '../../utils/enums.dart';
import '../tmdb_configs.dart';
import '../urls.dart';

class ImageQualitySetting {
  imageQualityOptions imageQuality;

  ImageQualitySetting(this.imageQuality);

  String imageUrl = URLS.imageBaseUrl;

  String getDisplayName(BuildContext context) {
    switch (imageQuality) {
      case imageQualityOptions.low:
        return "Low";
      case imageQualityOptions.high:
        return "High";
      case imageQualityOptions.medium:
      default:
        return "Medium";
    }
  }

  String getImageQuality() {
    switch (imageQuality) {
      case imageQualityOptions.low:
        return imageUrl + PosterSizes.w185;
      case imageQualityOptions.high:
        return imageUrl + PosterSizes.w500;
      case imageQualityOptions.medium:
      default:
        return imageUrl + PosterSizes.w342;
    }
  }

  // For saving to shared prefs
  int getIndex() {
    return imageQuality.index;
  }
}
