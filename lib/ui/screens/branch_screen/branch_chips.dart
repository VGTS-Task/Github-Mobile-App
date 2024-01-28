import 'package:flutter/material.dart';
import 'package:github_mobile_app/constants/app_dimensions.dart';
import 'package:github_mobile_app/constants/color_constants.dart';
import 'package:github_mobile_app/model/branch_model.dart';
import 'package:github_mobile_app/view-model/branch_provider.dart';

class BranchChip extends StatelessWidget {
  const BranchChip({required this.branchProvider, super.key});

  final BranchProvider branchProvider;

  List<Widget> _buildChips() {
    List<Widget> children = [];
    List<BranchModel> branchInfo = branchProvider.branchInfo;
    for (int i = 0; i < branchInfo.length; i++) {
      children.add(
        Padding(
          padding: const EdgeInsets.all(AppDimensions.paddingSmall2),
          child: GestureDetector(
            onTap: () {
              branchProvider.changeBranchSelectionIndex(i);
            },
            child: Chip(
              labelPadding: const EdgeInsets.symmetric(
                  vertical: AppDimensions.paddingNano,
                  horizontal: AppDimensions.paddingSM2),
              label: Text(
                branchInfo[i].branchName,
                style: TextStyle(
                    color: branchProvider.branchSelectionIndex == i
                        ? Colors.white
                        : Colors.black),
              ),
              backgroundColor: branchProvider.branchSelectionIndex == i
                  ? ColorConstants.chipSelectionColor
                  : ColorConstants.chipUnselectionColor,
            ),
          ),
        ),
      );
    }

    return children;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: _buildChips(),
      ),
    );
  }
}
