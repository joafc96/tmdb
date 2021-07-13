import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';
import 'package:tmdb/utils/reusable_widgets.dart';
import '../../models/tv_shows/tv_shows_data.dart';
import '../../styles.dart';
import '../../utils/assets_helper.dart';
import '../../utils/constants.dart';
import '../../view_models/bottom_nav_view_model.dart';
import '../../view_models/setting_view_models/grid_count_view_model.dart';
import '../../view_models/setting_view_models/image_quality_view_model.dart';
import '../../view_models/see_all_tv_shows_view_model.dart';
import '../../view_models/setting_view_models/theme_view_model.dart';
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

  Future<bool> _willPopCallback() async {
    await DefaultCacheManager().emptyCache();

    return true; // return true if the route to be popped
  }

  @override
  Widget build(BuildContext context) {
    final TvShowsList tvShowsList =
        Provider.of<SeeAllTvShowsViewModel>(context).tvShowsList;
    final tvShows = tvShowsList.tvShows;
    return WillPopScope(
      onWillPop: _willPopCallback,
      child: Scaffold(
          appBar: ScrollAppBar(
            centerTitle: true,
            leading: CupertinoButton(
                padding: EdgeInsets.zero,
                child: SvgPicture.asset(
                  ImageAssets.chevron_left,
                  width: kSpacingUnit * 3.5,
                  height: kSpacingUnit * 3.5,
                  color: Provider.of<ThemeViewModel>(context).curTheme.text,
                ),
                onPressed: () async {
                  await DefaultCacheManager().emptyCache();
                  context.read<BottomNavigationViewModel>().pop();
                }),
            controller: _scrollControllerUtil
                .scrollController, // Note the controller here
            elevation: 0.0,
            title: Text(
              tvShowsCategoryName[widget.tvShowsCategory],
              style: AppStyles.headerText(context).copyWith(letterSpacing: 0.2),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: kSpacingUnit * 0.8, vertical: kSpacingUnit * 0.8),
            child: GridView.builder(
              controller: _scrollControllerUtil.scrollController,
              cacheExtent: 12,
              itemCount: tvShows.length,
              itemBuilder: (context, index) => _Tile(index, tvShows[index]),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount:
                    Provider.of<GridCountViewModel>(context).curGridCount,
                childAspectRatio: 0.9 / 1.3,
                crossAxisSpacing: kSpacingUnit * 0.8,
                mainAxisSpacing: kSpacingUnit * 0.8,
              ),
            ),
          )),
    );
  }
}

class _Tile extends StatelessWidget {
  const _Tile(this.index, this.tvShowsData);

  final TvShowsData tvShowsData;
  final int index;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Container(
        decoration: BoxDecoration(
            color:
                Provider.of<ThemeViewModel>(context).curTheme.backgroundLight,
            borderRadius:
                BorderRadius.all(Radius.circular(kSpacingUnit * 0.6))),
        child: Stack(
          clipBehavior: Clip.none,
          fit: StackFit.expand,
          children: [
            ClipRRect(
              borderRadius:
                  BorderRadius.all(Radius.circular(kSpacingUnit * 0.6)),
              child: FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: Provider.of<ImageQualityViewModel>(context)
                        .curImageQuality +
                    tvShowsData.posterPath,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
