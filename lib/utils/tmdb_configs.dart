// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:flutter_dotenv/flutter_dotenv.dart';

//TMDb(https://www.themoviedb.org) Api Key
 String apiKey = dotenv.env['API_KEY'];

const int timeOutDuration = 15;

class BackDropSizes {
  static const String w300 = 'w300';
  static const String w780 = 'w780';
  static const String w1280 = 'w1280';
  static const String original = 'original';
}

class LogoSizes {
  static const String w45 = 'w45';
  static const String w92 = 'w92';
  static const String w154 = 'w154';
  static const String w185 = 'w185';
  static const String w300 = 'w300';
  static const String w500 = 'w500';
  static const String original = 'original';
}

class PosterSizes {
  static const String w92 = 'w92';
  static const String w154 = 'w154';
  static const String w185 = 'w185';
  static const String w342 = 'w342';
  static const String w500 = 'w500';
  static const String w780 = 'w780';
  static const String original = 'original';
}

class ProfileSizes {
  static const String w45 = 'w45';
  static const String w185 = 'w185';
  static const String w632 = 'w632';
  static const String original = 'original';
}

class StillSizes {
  static const String w92 = 'w92';
  static const String w185 = 'w185';
  static const String w300 = 'w300';
  static const String original = 'original';
}

String getThumbnail({
  @required String videoId,
}) =>
    'https://i.ytimg.com/vi/$videoId/${ThumbnailQuality.medium}';

class ThumbnailQuality {
  /// 120*90
  static const String defaultQuality = 'default.jpg';

  /// 320*180
  static const String medium = 'mqdefault.jpg';

  /// 480*360
  static const String high = 'hqdefault.jpg';

  /// 640*480
  static const String standard = 'sddefault.jpg';

  /// Unscaled thumbnail
  static const String max = 'maxresdefault.jpg';
}
