import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:github_mobile_app/constants/app_dimensions.dart';
import 'package:github_mobile_app/constants/color_constants.dart';
import 'package:github_mobile_app/model/repository_model.dart';

class CommonReposTile extends StatelessWidget {
  const CommonReposTile({
    required this.repositoryInfo,
    this.nameColor,
    this.ownerNameColor,
    this.showArrorIcon = true,
    super.key,
  });
  final RepositoryModel repositoryInfo;
  final Color? nameColor;
  final Color? ownerNameColor;
  final bool showArrorIcon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingSM2,
          vertical: AppDimensions.paddingMedium),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(AppDimensions.radiusSmall2),
            child: Image.network(
              repositoryInfo.reposImgURL ?? repositoryInfo.orgImgURL,
              height: 45,
              width: 45,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: AppDimensions.paddingSmall2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    repositoryInfo.name,
                    style: TextStyle(
                      fontSize: AppDimensions.headline3Size,
                      color: nameColor,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: AppDimensions.paddingTS),
                    child: Text(
                      repositoryInfo.ownerName,
                      style: TextStyle(
                        fontSize: AppDimensions.overlineSize,
                        color: ownerNameColor ?? ColorConstants.secondaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (showArrorIcon)
            SvgPicture.asset(
              "assets/images/forward_arrow.svg",
              height: 24,
              width: 24,
            ),
        ],
      ),
    );
  }
}
