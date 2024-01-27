import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:github_mobile_app/constants/app_dimensions.dart';
import 'package:github_mobile_app/constants/color_constants.dart';
import 'package:github_mobile_app/constants/string_constants.dart';
import 'package:github_mobile_app/ui/screens/org_drawer.dart';
import 'package:github_mobile_app/view-model/login_provider.dart';
import 'package:github_mobile_app/view-model/profile_provider.dart';
import 'package:provider/provider.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardpageState();
}

class _DashboardpageState extends State<DashboardPage> {
  @override
  void initState() {
    _getAccessToken();
    super.initState();
  }

  _getAccessToken() async {
    LoginProvider loginProvider =
        Provider.of<LoginProvider>(context, listen: false);
    await loginProvider.getAccessTokenFromLocal();
    if (mounted) {
      ProfileProvider profileProvider =
          Provider.of<ProfileProvider>(context, listen: false);
      profileProvider.getProfileInfoFromLocal();
      profileProvider.getOrgs(context, loginProvider.accessToken!);
    }
  }

  @override
  Widget build(BuildContext context) {
    _getAccessToken();
    return Consumer<ProfileProvider>(
        builder: (context, profileProvider, child) {
      if (profileProvider.isLoading && profileProvider.profileModel == null) {
        return const Center(
          child: CircularProgressIndicator(
            color: ColorConstants.primary,
          ),
        );
      }

      print(profileProvider.profileModel);

      return Scaffold(
          appBar: AppBar(
            centerTitle: false,
            title: const Text(
              StringConstants.gitHub,
              textAlign: TextAlign.left,
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(
                    right: AppDimensions.bellIconPaddingRight),
                child: SvgPicture.asset("assets/images/bell_icon.svg"),
              ),
            ],
          ),
          drawer: const OrgDrawer());
    });
  }
}
