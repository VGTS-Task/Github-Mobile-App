import 'package:flutter/material.dart';
import 'package:github_mobile_app/constants/app_dimensions.dart';
import 'package:github_mobile_app/constants/color_constants.dart';
import 'package:github_mobile_app/constants/string_constants.dart';
import 'package:github_mobile_app/model/repository_model.dart';
import 'package:github_mobile_app/ui/screens/branch_screen/branch_body.dart';
import 'package:github_mobile_app/ui/screens/common/common_repository_tile.dart';
import 'package:github_mobile_app/ui/screens/utils.dart';
import 'package:github_mobile_app/view-model/branch_provider.dart';
import 'package:github_mobile_app/view-model/login_provider.dart';
import 'package:provider/provider.dart';

class BranchHome extends StatefulWidget {
  const BranchHome({required this.repositoryInfo, super.key});

  final RepositoryModel repositoryInfo;

  @override
  State<BranchHome> createState() => _BranchHomeState();
}

class _BranchHomeState extends State<BranchHome> {
  late BranchProvider _branchProvider;

  @override
  void initState() {
    _branchProvider = Provider.of<BranchProvider>(context, listen: false);
    LoginProvider loginProvider =
        Provider.of<LoginProvider>(context, listen: false);
    _branchProvider.getBranchInfo(
        context, widget.repositoryInfo.branchURL, loginProvider.accessToken!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          StringConstants.project,
          textAlign: TextAlign.left,
        ),
      ),
      body: Column(
        children: [
          ColoredBox(
            color: ColorConstants.primary,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonReposTile(
                  repositoryInfo: widget.repositoryInfo,
                  nameColor: Colors.white,
                  ownerNameColor: ColorConstants.ownerNameColorDark,
                  showArrorIcon: false,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: AppDimensions.paddingSM2,
                      bottom: AppDimensions.paddingML),
                  child: Text(
                    "Last update: ${getFormatString(widget.repositoryInfo.lastUpdatedTym ?? widget.repositoryInfo.createdTym, "dd/MM/yyyy h:mma").toLowerCase()}",
                    style: const TextStyle(
                      color: ColorConstants.lastUpdateTextColor,
                      fontSize: AppDimensions.headline4Size,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Expanded(child: BranchBody())
        ],
      ),
    );
  }
}
