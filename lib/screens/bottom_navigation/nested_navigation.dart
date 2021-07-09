import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../screens/account/account.dart';
import '../../screens/home/home.dart';
import '../../utils/custom_page_transitions.dart';
import '../../view_models/bottom_nav_view_model.dart';

import '../../utils/widgets/bottom_nav_component.dart';

enum tabItem { movies, tvShows, celebs, search, account }

class NestedNavigation extends StatefulWidget {
  @override
  _NestedNavigationState createState() => _NestedNavigationState();
}

class _NestedNavigationState extends State<NestedNavigation> {
  final _pages = [
    Home(),
    const Scaffold(),
    const Scaffold(),
    Account()
  ];

  Widget _buildOffStageNavigator(
      BottomNavigationViewModel bottomNavModel, int index) {
    return Offstage(
      offstage: bottomNavModel.index != index,
      child: Navigator(
        key: bottomNavModel.navigationKeys[index],
        onGenerateRoute: (routeSettings) {
          return FadeTransitionPageRoute(
              page: _pages[index], settings: routeSettings);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bottomNavModel = Provider.of<BottomNavigationViewModel>(context);

    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab = await bottomNavModel.onPopBack();
        return isFirstRouteInCurrentTab;
      },
      child: Scaffold(
          body: Stack(
            children: <Widget>[
              _buildOffStageNavigator(bottomNavModel, 0),
              _buildOffStageNavigator(bottomNavModel, 1),
              _buildOffStageNavigator(bottomNavModel, 2),
              _buildOffStageNavigator(bottomNavModel, 3),
            ],
          ),
          bottomNavigationBar: BottomNavComponent(
            currentIndex: bottomNavModel.index,
            onChange: (index) {
              bottomNavModel.selectTab(index);
            },
          )),
    );
  }
}
