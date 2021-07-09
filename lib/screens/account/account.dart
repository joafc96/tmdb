import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../screens/account/account_local_widgets.dart';
import '../../utils/constants.dart';
import '../../view_models/bottom_nav_view_model.dart';
import '../../view_models/login_info_model.dart';

import '../../styles.dart';


class Account extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final LoginInfoViewModel _loginInfoViewModel =
        Provider.of<LoginInfoViewModel>(context);

    return Scaffold(
      body: Align(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: AppConstants.kSpacingUnit * 10.0,
                width: AppConstants.kSpacingUnit * 10.0,
                margin: EdgeInsets.only(top: AppConstants.kSpacingUnit * 3.0),
                child: CircleAvatar(
                  radius: AppConstants.kSpacingUnit * 5.0,
                  backgroundImage: NetworkImage(_loginInfoViewModel.photoUrl),
                ),
              ),
              SizedBox(height: AppConstants.kSpacingUnit * 2.0),
              Text(
                _loginInfoViewModel.displayName,
                style: AppStyles.textStyleParagraph(context),
              ),
              SizedBox(height: AppConstants.kSpacingUnit * 0.5),
              Text(
                _loginInfoViewModel.email,
                style: AppStyles.textStyleParagraphThinPrimary(context),
              ),
              SizedBox(height: AppConstants.kSpacingUnit * 2.0),
              // Container(
              //   height: kSpacingUnit * 4.0,
              //   width: kSpacingUnit * 20.0,
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(kSpacingUnit * 3.0),
              //     color: context.watch<ThemeViewModel>().curTheme.primary,
              //   ),
              //   child: Center(
              //     child: Text(
              //       'Upgrade to PRO',
              //       // style: AppStyles.textStyleButtonBackGroundSmall(context),
              //     ),
              //   ),
              // ),

              ProfileListItem(
                icon: Icons.privacy_tip,
                text: 'Privacy',
              ),
              ProfileListItem(
                icon: Icons.star,
                text: 'Theme',
              ),
        
              ProfileListItem(
                icon: Icons.settings,
                text: 'Settings',
              ),
         
              ProfileListItem(
                icon: Icons.logout,
                text: 'Logout',
                hasNavigation: false,
                onTap: () async {
                  await Provider.of<LoginInfoViewModel>(context, listen: false)
                      .signOut(context);
                  await context
                      .read<BottomNavigationViewModel>()
                      .navigateToAndClear("/login");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
