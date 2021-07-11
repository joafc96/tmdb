// Dart imports:
import 'dart:ui';

// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

// Project imports:
import '../../view_models/setting_view_models/theme_view_model.dart';
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
          height: kSpacingUnit * 6.0,
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
                height: kSpacingUnit * 0.8,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: kSpacingUnit * 2.5),
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
                                width: kSpacingUnit * 3.0,
                                height: kSpacingUnit * 3.0,
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
