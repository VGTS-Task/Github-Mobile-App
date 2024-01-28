import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:github_mobile_app/constants/app_dimensions.dart';
import 'package:github_mobile_app/constants/string_constants.dart';
import 'package:github_mobile_app/model/repository_model.dart';
import 'package:github_mobile_app/ui/screens/repository/repository_tile.dart';
import 'package:github_mobile_app/view-model/login_provider.dart';
import 'package:github_mobile_app/view-model/profile_provider.dart';
import 'package:github_mobile_app/view-model/repository_provider.dart';

class RepositoryList extends StatefulWidget {
  const RepositoryList({
    required this.profileProvider,
    required this.reposURL,
    super.key,
  });

  final ProfileProvider profileProvider;
  final String reposURL;

  @override
  State<RepositoryList> createState() => _RepositoryListState();
}

class _RepositoryListState extends State<RepositoryList> {
  late RepositoryProvider _repositoryprovider;

  @override
  void initState() {
    _repositoryprovider =
        Provider.of<RepositoryProvider>(context, listen: false);
    LoginProvider loginProvider =
        Provider.of<LoginProvider>(context, listen: false);
    _repositoryprovider.getRepositopries(
        context, widget.reposURL, loginProvider.accessToken!);
    super.initState();
  }

  List<Widget> _buildRepos(List<RepositoryModel> repositoryInfo) {
    List<Widget> reposTiles = [];
    for (int i = 0; i < repositoryInfo.length; i++) {
      reposTiles.add(RepositoryTile(repositoryInfo: repositoryInfo[i]));
    }
    return reposTiles;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RepositoryProvider>(builder: (context, provider, child) {
      if (provider.isLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      List<Widget> children = [];
      if (provider.repositoryInfo.isEmpty) {
        children.add(const Center(
          child: Padding(
            padding: EdgeInsets.only(top: AppDimensions.paddingXXLaarge),
            child: Text("No repository in the organisation"),
          ),
        ));
      } else {
        children = _buildRepos(provider.repositoryInfo);
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            StringConstants.projects,
            style: TextStyle(fontSize: AppDimensions.inputSize),
          ),
          ...children
        ],
      );
    });
  }
}
