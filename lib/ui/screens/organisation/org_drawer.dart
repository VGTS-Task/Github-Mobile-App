import 'package:flutter/material.dart';
import 'package:github_mobile_app/constants/app_dimensions.dart';
import 'package:github_mobile_app/constants/color_constants.dart';
import 'package:github_mobile_app/model/profile_model.dart';
import 'package:github_mobile_app/ui/screens/common/dialog_box.dart';
import 'package:github_mobile_app/ui/screens/organisation/logout_tile.dart';
import 'package:github_mobile_app/ui/screens/organisation/org_tile.dart';
import 'package:github_mobile_app/view-model/authentication.dart';
import 'package:github_mobile_app/view-model/profile_provider.dart';
import 'package:provider/provider.dart';

class OrgDrawer extends StatefulWidget {
  const OrgDrawer({super.key});

  @override
  State<OrgDrawer> createState() => _OrgDrawerState();
}

class _OrgDrawerState extends State<OrgDrawer> {
  List<Widget> _buildOrgs(ProfileModel profileInfo) {
    if (profileInfo.orgDetails == null) {
      return [];
    }

    List<Widget> orgTiles = [];

    for (var orgInfo in profileInfo.orgDetails!) {
      orgTiles.add(OrgTile(orgDetails: orgInfo));
    }

    for (var orgInfo in profileInfo.orgDetails!) {
      orgTiles.add(OrgTile(orgDetails: orgInfo));
    }

    orgTiles.add(GestureDetector(
        onTap: () {
          logoutDialog(context,
              navigationDelegate: (request) =>
                  Authentication.handleWebviewNavigation(context, request));
        },
        child: const LogoutTile()));

    return orgTiles;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * 0.70,
      child: ColoredBox(
        color: Colors.white,
        child: Consumer<ProfileProvider>(
          builder: (context, profileProvider, child) {
            ProfileModel profileInfo = profileProvider.profileModel!;
            return SafeArea(
              child: SizedBox(
                height: size.height,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppDimensions.bodyPadding),
                    child: Column(
                      children: [
                        ColoredBox(
                          color: ColorConstants.profileTileColor,
                          child: Padding(
                            padding:
                                const EdgeInsets.all(AppDimensions.paddingML),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Image.network(
                                  profileInfo.imgURL,
                                  height: 45,
                                  width: 45,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: AppDimensions.bodyPadding),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        profileInfo.name,
                                        style: const TextStyle(
                                            fontSize:
                                                AppDimensions.headline3Size),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: AppDimensions.paddingTS),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                              AppDimensions.radiusSmall),
                                          child: ColoredBox(
                                            color: ColorConstants.userNameColor,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: AppDimensions
                                                          .paddingSmall2,
                                                      vertical: AppDimensions
                                                          .paddingTiny),
                                              child: Text(
                                                profileInfo.userName ??
                                                    "Hello Sury",
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: AppDimensions
                                                        .captionSize),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        ..._buildOrgs(profileInfo)
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
