import 'package:flutter/material.dart';
import 'package:github_mobile_app/constants/app_dimensions.dart';
import 'package:github_mobile_app/constants/color_constants.dart';
import 'package:github_mobile_app/model/profile_model.dart';

class OrgTile extends StatefulWidget {
  const OrgTile({
    required this.orgDetails,
    this.isSelectedTile = false,
    super.key,
  });

  final OrgDetails orgDetails;
  final bool isSelectedTile;

  @override
  State<OrgTile> createState() => _OrgTileState();
}

class _OrgTileState extends State<OrgTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppDimensions.paddingTiny),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppDimensions.radiusTiny),
        child: ColoredBox(
          color: ColorConstants.orgSelectionColor,
          child: Padding(
            padding: const EdgeInsets.all(AppDimensions.paddingSmall2),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius:
                      BorderRadius.circular(AppDimensions.radiusSmall2),
                  child: Image.network(
                    widget.orgDetails.orgImgURL,
                    height: 40,
                    width: 40,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: AppDimensions.paddingSmall),
                  child: Text(
                    widget.orgDetails.name,
                    style:
                        const TextStyle(fontSize: AppDimensions.headline3Size),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
