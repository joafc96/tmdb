import 'package:flutter/cupertino.dart';
import '../../utils/reusable_widgets.dart';

class Poster extends StatelessWidget {
  final String imageUrl;
  final String heroTag;

  const Poster({Key key, this.imageUrl, this.heroTag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: heroTag,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6.0),
        child: getCachedNetworkImage(url: imageUrl, fit: BoxFit.fill),
      ),
    );
  }
}
