import 'package:flutter/material.dart';
import '../../models/tv_shows/tv_shows_list.dart';
import '../../utils/enums.dart';
import '../../utils/scroll_controller_util.dart';

class SeeAllTvShows extends StatefulWidget {
  final TvShowsCategories tvShowsCategory;
  final TvShowsList tvShowsList;
  final int tvShowId;

  SeeAllTvShows(
      {Key key,
      this.tvShowsCategory,
      @required this.tvShowsList,
      this.tvShowId})
      : assert(tvShowsList != null),
        super(key: key);

  @override
  _SeeAllTvShowsState createState() => _SeeAllTvShowsState();
}

class _SeeAllTvShowsState extends State<SeeAllTvShows> {
  final _scrollControllerUtil = ScrollControllerUtil();

  @override
  void initState() {
    super.initState();
    _scrollControllerUtil.addScrollListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
