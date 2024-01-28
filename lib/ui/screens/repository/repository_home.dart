import 'package:flutter/material.dart';
import 'package:github_mobile_app/constants/app_dimensions.dart';
import 'package:github_mobile_app/constants/color_constants.dart';
import 'package:github_mobile_app/model/org_model.dart';
import 'package:github_mobile_app/model/profile_model.dart';
import 'package:github_mobile_app/ui/screens/repository/repository_list.dart';
import 'package:github_mobile_app/view-model/profile_provider.dart';

class RepositoryHome extends StatefulWidget {
  const RepositoryHome(
      {required this.profileProvider, required this.orgDetails, super.key});

  final ProfileProvider profileProvider;
  final OrgDetails orgDetails;

  @override
  State<RepositoryHome> createState() => _RepositoryHomeState();
}

class _RepositoryHomeState extends State<RepositoryHome> {
  @override
  Widget build(BuildContext context) {
    ProfileModel profileInfo = widget.profileProvider.profileModel!;
    return Padding(
      padding: const EdgeInsets.only(
          left: AppDimensions.bodyPadding,
          right: AppDimensions.bodyPadding,
          top: AppDimensions.paddingXLarge),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(AppDimensions.radiusSmall2)),
            child: SizedBox(
              height: 108,
              child: Padding(
                padding: const EdgeInsets.all(AppDimensions.bodyPadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius:
                          BorderRadius.circular(AppDimensions.radiusSmall2),
                      child: Image.network(
                        profileInfo.imgURL,
                        height: 45,
                        width: 45,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: AppDimensions.bodyPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            profileInfo.name,
                            style: const TextStyle(
                                fontSize: AppDimensions.headline3Size),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: AppDimensions.paddingTS),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  AppDimensions.radiusSmall),
                              child: ColoredBox(
                                color: ColorConstants.orgBgColor,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: AppDimensions.paddingSmall2,
                                      vertical: AppDimensions.paddingTiny),
                                  child: Text(
                                    widget.orgDetails.name,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: AppDimensions.captionSize),
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
          ),
          Padding(
            padding: const EdgeInsets.only(top: AppDimensions.paddingSmall2),
            child: RepositoryList(
              profileProvider: widget.profileProvider,
              reposURL: widget.orgDetails.reposURL,
            ),
          ),
        ],
      ),
    );
  }
}
