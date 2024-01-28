import 'package:github_mobile_app/model/commit_model.dart';

class BranchModel {
  const BranchModel({
    required this.branchName,
    required this.branchCommits,
  });

  final String branchName;
  final List<CommitModel> branchCommits;
}
