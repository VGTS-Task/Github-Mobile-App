import 'package:flutter/material.dart';
import 'package:github_mobile_app/model/repository_model.dart';
import 'package:github_mobile_app/ui/screens/branch_screen/branch_home.dart';
import 'package:github_mobile_app/ui/screens/common/common_repository_tile.dart';

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
                        BranchHome(repositoryInfo: widget.repositoryInfo)));
          },
          child: CommonReposTile(
            repositoryInfo: widget.repositoryInfo,
          ),
        ),
      ),
    );
  }
}
