import 'package:flutter/material.dart';
import 'package:github_mobile_app/constants/app_dimensions.dart';
import 'package:github_mobile_app/constants/color_constants.dart';
import 'package:github_mobile_app/model/repository_model.dart';

class RepositoryTile extends StatefulWidget {
  const RepositoryTile({required this.repositoryInfo, super.key});
  final RepositoryModel repositoryInfo;

  @override
  State<RepositoryTile> createState() => _RepositoryTileState();
}

class _RepositoryTileState extends State<RepositoryTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Card(
        child: InkWell(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(AppDimensions.paddingSM2),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius:
                      BorderRadius.circular(AppDimensions.radiusSmall2),
                  child: Image.network(
                    widget.repositoryInfo.reposImgURL ??
                        widget.repositoryInfo.orgImgURL,
                    height: 45,
                    width: 45,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: AppDimensions.paddingSmall2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.repositoryInfo.name,
                          style: const TextStyle(
                              fontSize: AppDimensions.headline3Size),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: AppDimensions.paddingTS),
                          child: Text(
                            widget.repositoryInfo.ownerName,
                            style: const TextStyle(
                                fontSize: AppDimensions.overlineSize,
                                color: ColorConstants.ownerNameColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Icon(
                  Icons.keyboard_arrow_right,
                  size: 24,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
