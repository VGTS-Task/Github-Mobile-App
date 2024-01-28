import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:github_mobile_app/constants/app_dimensions.dart';
import 'package:github_mobile_app/constants/color_constants.dart';
import 'package:github_mobile_app/model/org_model.dart';
import 'package:github_mobile_app/view-model/profile_provider.dart';

class OrgTile extends StatefulWidget {
  const OrgTile({
    required this.orgDetails,
    required this.index,
    super.key,
  });

  final OrgDetails orgDetails;
  final int index;

  @override
  State<OrgTile> createState() => _OrgTileState();
}

class _OrgTileState extends State<OrgTile> {
  late ProfileProvider _profileProvider;

  @override
  void initState() {
    _profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppDimensions.paddingTiny),
      child: GestureDetector(
        onTap: () {
          _profileProvider.changeOrgSelectedIndex(widget.index, context);
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppDimensions.radiusTiny),
          child: ColoredBox(
            color: widget.index == _profileProvider.orgSelectedIndex
                ? ColorConstants.orgSelectionColor
                : Colors.transparent,
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
                      style: const TextStyle(
                          fontSize: AppDimensions.headline3Size),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
