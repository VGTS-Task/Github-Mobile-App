import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:github_mobile_app/constants/app_dimensions.dart';
import 'package:github_mobile_app/constants/color_constants.dart';
import 'package:github_mobile_app/constants/string_constants.dart';
import 'package:github_mobile_app/model/branch_model.dart';
import 'package:github_mobile_app/model/commit_model.dart';
import 'package:github_mobile_app/ui/screens/utils.dart';

class BranchTiles extends StatelessWidget {
  const BranchTiles({required this.branchInfo, super.key});

  final BranchModel branchInfo;

  List<Widget> _buildBranchTile() {
    List<Widget> children = [];
    for (var commitInfo in branchInfo.branchCommits) {
      children.add(BranchTile(commitInfo: commitInfo));
      children.add(const Divider());
    }

    return children;
  }

  @override
  Widget build(BuildContext context) {
    List<CommitModel> branchCommits = branchInfo.branchCommits;

    if (branchCommits.isEmpty) {
      return const Center(
        child: Text(StringConstants.noCommits),
      );
    }
    return Column(
      children: _buildBranchTile(),
    );
  }
}

class BranchTile extends StatelessWidget {
  const BranchTile({required this.commitInfo, super.key});

  final CommitModel commitInfo;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(AppDimensions.radiusSmall2),
          child: ColoredBox(
            color: ColorConstants.folderBackgroundColor,
            child: SizedBox(
              height: 40,
              width: 40,
              child: SvgPicture.asset(
                "assets/images/folder_icon.svg",
                height: 24,
                width: 24,
                fit: BoxFit.none,
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: AppDimensions.paddingSmall2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3.0),
                  child: Text(
                    commitInfo.commitName,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: AppDimensions.inputSize),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3.0),
                  child: Text(
                      getFormatString(commitInfo.commitTym, "dd/MM/yy h:mma")),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 7.0),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        "assets/images/user_icon.svg",
                        height: 14,
                        width: 12,
                        fit: BoxFit.none,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: AppDimensions.paddingTS),
                        child: Text(
                          commitInfo.commiterName,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: AppDimensions.headline5Size),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
