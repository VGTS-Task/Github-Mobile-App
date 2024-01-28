import 'package:flutter/material.dart';
import 'package:github_mobile_app/constants/app_dimensions.dart';
import 'package:github_mobile_app/constants/string_constants.dart';
import 'package:github_mobile_app/ui/screens/branch_screen/branch_chips.dart';
import 'package:github_mobile_app/ui/screens/branch_screen/branch_tiles.dart';
import 'package:github_mobile_app/view-model/branch_provider.dart';
import 'package:provider/provider.dart';

class BranchBody extends StatefulWidget {
  const BranchBody({super.key});

  @override
  State<BranchBody> createState() => _BranchBodyState();
}

class _BranchBodyState extends State<BranchBody> {
  @override
  Widget build(BuildContext context) {
    return Consumer<BranchProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (provider.branchInfo.isEmpty) {
          return const Center(
            child: Text(StringConstants.noBranches),
          );
        }

        return Column(
          children: [
            BranchChip(branchProvider: provider),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(AppDimensions.paddingSmall2),
                child: SingleChildScrollView(
                  child: BranchTiles(
                    branchInfo:
                        provider.branchInfo[provider.branchSelectionIndex],
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
