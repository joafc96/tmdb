import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmdb/styles.dart';
import 'package:tmdb/view_models/image_quality_view_model.dart';
import 'package:tmdb/view_models/see_all_tv_shows_view_model.dart';
import '../../models/tv_shows/tv_shows_list.dart';
import '../../utils/enums.dart';
import '../../utils/scroll_controller_util.dart';

class SeeAllTvShows extends StatefulWidget {
  static Widget create(arguments) {
    return ChangeNotifierProvider(
      create: (_) => SeeAllTvShowsViewModel(arguments['tv_shows_list']),
      child: SeeAllTvShows(
          tvShowsCategory: arguments['tv_show_category'],
          tvShowsList: arguments['tv_shows_list'],
          tvShowId: arguments['tv_show_id']),
    );
  }

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
    _scrollControllerUtil.addScrollListener(() {
      if (!(context.read<SeeAllTvShowsViewModel>().state ==
          ViewState.loading)) {
        context.read<SeeAllTvShowsViewModel>().getTvShows(
            context: context,
            tvShowId: widget.tvShowId,
            tvShowsCategory: widget.tvShowsCategory);
      }
    });
  }

  @override
  void dispose() {
    _scrollControllerUtil.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.tvShowsCategory.toString(),
          style: AppStyles.headerPrimary(context),
        ),
      ),
      body: Builder(builder: (context) {
        final TvShowsList tvShowsList =
            Provider.of<SeeAllTvShowsViewModel>(context).tvShowsList;
        final tvShows = tvShowsList.tvShows;

        return OrientationBuilder(builder: (context, orientation) {
          return GridView.builder(
            controller: _scrollControllerUtil.scrollController,
            itemCount: tvShows.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 20,
                crossAxisCount: (orientation == Orientation.portrait) ? 3 : 4),
            itemBuilder: (BuildContext context, int index) {
              return Container(
                  height: 100,
                  width: 63,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 0.5),
                  ),
                  child: Image.network(
                      Provider.of<ImageQualityViewModel>(context)
                              .curImageQuality +
                          tvShows[index].posterPath,
                      fit: BoxFit.fill));
            },
          );
        });
      }),
    );
  }
}
