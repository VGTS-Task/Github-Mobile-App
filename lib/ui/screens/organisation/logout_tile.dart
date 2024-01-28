import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:github_mobile_app/constants/app_dimensions.dart';
import 'package:github_mobile_app/constants/string_constants.dart';

class LogoutTile extends StatelessWidget {
  const LogoutTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppDimensions.paddingTiny),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppDimensions.radiusTiny),
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.paddingSmall2),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(AppDimensions.radiusSmall2),
                child: SvgPicture.asset(
                  "assets/images/logout.svg",
                  height: 40,
                  width: 40,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: AppDimensions.paddingSmall),
                child: Text(
                  StringConstants.logout,
                  style: TextStyle(fontSize: AppDimensions.headline3Size),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
