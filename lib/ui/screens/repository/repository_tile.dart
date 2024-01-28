import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:github_mobile_app/model/repository_model.dart';
import 'package:github_mobile_app/ui/screens/branch_screen/branch_home.dart';
import 'package:github_mobile_app/ui/screens/common/common_repository_tile.dart';
import 'package:github_mobile_app/view-model/branch_provider.dart';

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
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    BranchHome(repositoryInfo: widget.repositoryInfo),
              ),
            ).then(
              (value) {
                BranchProvider provider =
                    Provider.of<BranchProvider>(context, listen: false);
                provider.resetValue();
              },
            );
          },
          child: CommonReposTile(
            repositoryInfo: widget.repositoryInfo,
          ),
        ),
      ),
    );
  }
}
