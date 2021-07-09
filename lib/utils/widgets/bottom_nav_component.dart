import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../view_models/theme_view_model.dart';
import '../constants.dart';

class BottomNavComponent extends StatelessWidget {
  final int currentIndex;
  final Function(int tabItem) onChange;

  final List<List<String>> icons = [
    ["assets/svg_icons/home.svg", "Movie"],
    ["assets/svg_icons/search.svg", "Search"],
    ["assets/svg_icons/bookmark.svg", "WatchList"],
    ["assets/svg_icons/user.svg", "User"]
  ];

  BottomNavComponent({
    Key key,
    @required this.currentIndex,
    this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 5.0,
          sigmaY: 5.0,
        ),
        child: Container(
          height: AppConstants.kSpacingUnit * 6.0,
          decoration: BoxDecoration(
            color: Provider.of<ThemeViewModel>(context, listen: true)
                .curTheme
                .background,
          ),
          child: Column(
            children: [
              Container(
                height: 1,
                color: Provider.of<ThemeViewModel>(context, listen: true)
                    .curTheme
                    .primary,
              ),
              const SizedBox(
                height: AppConstants.kSpacingUnit * 0.8,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppConstants.kSpacingUnit * 2.5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ...icons
                        .asMap()
                        .map(
                          (index, value) => MapEntry(
                            index,
                            CupertinoButton(
                              onPressed: () {
                                onChange(index);
                              },
                              padding: const EdgeInsets.all(0),
                              child: SvgPicture.asset(
                                value[0],
                                width: AppConstants.kSpacingUnit * 3.0,
                                height: AppConstants.kSpacingUnit * 3.0,
                                color: currentIndex == index
                                    ? Provider.of<ThemeViewModel>(context,
                                            listen: true)
                                        .curTheme
                                        .primary
                                    : Provider.of<ThemeViewModel>(context,
                                            listen: true)
                                        .curTheme
                                        .text,
                              ),
                            ),
                          ),
                        )
                        .values
                        .toList()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
