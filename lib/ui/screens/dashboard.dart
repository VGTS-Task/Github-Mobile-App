import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:github_mobile_app/constants/app_dimensions.dart';
import 'package:github_mobile_app/constants/color_constants.dart';
import 'package:github_mobile_app/constants/string_constants.dart';
import 'package:github_mobile_app/ui/screens/organisation/org_drawer.dart';
import 'package:github_mobile_app/ui/screens/repository/repository_home.dart';
import 'package:github_mobile_app/view-model/login_provider.dart';
import 'package:github_mobile_app/view-model/profile_provider.dart';

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
    return Consumer<ProfileProvider>(
      builder: (context, profileProvider, child) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: false,
            title: const Text(
              StringConstants.gitHub,
              textAlign: TextAlign.left,
            ),
            actions: [
              Padding(
                padding:
                    const EdgeInsets.only(right: AppDimensions.paddingMedium),
                child: SvgPicture.asset("assets/images/bell_icon.svg"),
              ),
            ],
          ),
          drawer: const OrgDrawer(),
          body: BuildRepository(
            profileProvider: profileProvider,
          ),
        );
      },
    );
  }
}

class BuildRepository extends StatelessWidget {
  const BuildRepository({
    required this.profileProvider,
    super.key,
  });

  final ProfileProvider profileProvider;

  @override
  Widget build(BuildContext context) {
    if (profileProvider.isLoading ||
        profileProvider.profileModel == null ||
        profileProvider.profileModel!.orgDetails == null) {
      return const ColoredBox(
        color: Colors.white,
        child: Center(
          child: CircularProgressIndicator(
            color: ColorConstants.primary,
          ),
        ),
      );
    }

    if (profileProvider.profileModel!.orgDetails!.isEmpty) {
      return const Center(child: Text("No Organization"));
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                ColoredBox(
                  color: ColorConstants.primary,
                  child: SizedBox(
                    height: 90,
                    width: double.infinity,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: AppDimensions.paddingML),
                      child: Text(
                        "Hi ${profileProvider.profileModel!.name}",
                        style:
                            const TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                RepositoryHome(
                  key: ValueKey("${profileProvider.orgSelectedIndex}"),
                  profileProvider: profileProvider,
                  orgDetails: profileProvider.profileModel!
                      .orgDetails![profileProvider.orgSelectedIndex],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
