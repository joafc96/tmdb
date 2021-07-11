// Flutter imports:
import 'package:flutter/cupertino.dart';

// Project imports:
import '../../utils/reusable_widgets.dart';
import '../constants.dart';

class Poster extends StatelessWidget {
  final String imageUrl;
  final String heroTag;

  const Poster({Key key, this.imageUrl, this.heroTag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: heroTag,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(kSpacingUnit * 0.6),
        child: getCachedNetworkImage(url: imageUrl, fit: BoxFit.fill),
      ),
    );
  }
}
