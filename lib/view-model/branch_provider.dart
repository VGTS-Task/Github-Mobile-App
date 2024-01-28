import 'package:flutter/material.dart';
import 'package:github_mobile_app/model/branch_model.dart';
import 'package:github_mobile_app/model/commit_model.dart';
import 'package:github_mobile_app/ui/screens/common/error_dialog.dart';
import 'package:github_mobile_app/view-model/http_service.dart';

class BranchProvider extends ChangeNotifier {
  bool isLoading = false;
  List<BranchModel> branchInfo = [];
  int branchSelectionIndex = 0;

  changeBranchSelectionIndex(index) {
    branchSelectionIndex = index;
    notifyListeners();
  }

  resetValue() {
    branchInfo = [];
    branchSelectionIndex = 0;
    notifyListeners();
  }

  void getBranchInfo(BuildContext context, String url, String token) async {
    try {
      isLoading = true;
      List<dynamic>? branchList = await HttpService.getGithubResponse(
          context, url.replaceFirst("{/branch}", ""),
          token: token);
      List<BranchModel> branchDetails = [];
      if (branchList != null) {
        for (var branchInfo in branchList) {
          String commitUrl = branchInfo["commit"]["url"];
          List<String> splitURL = commitUrl.split("/");
          splitURL.removeLast();
          if (context.mounted) {
            List<dynamic>? commitList = await HttpService.getGithubResponse(
                context, "${splitURL.join("/")}?sha=${branchInfo["name"]}",
                token: token);
            if (commitList != null) {
              List<CommitModel> commitDetails = [];
              for (Map<String, dynamic> commitInfo in commitList) {
                Map<String, dynamic> commitDetail = commitInfo["commit"];
                commitDetails.add(
                  CommitModel(
                    commitName: commitDetail["message"],
                    commiterName: commitDetail["author"]["name"],
                    commitTym: commitDetail["author"]["date"],
                  ),
                );
              }
              branchDetails.add(
                BranchModel(
                  branchName: branchInfo["name"],
                  branchCommits: commitDetails,
                ),
              );
            } else {
              branchDetails.add(
                BranchModel(
                  branchName: branchInfo["name"],
                  branchCommits: [],
                ),
              );
            }
          }
        }
      }

      isLoading = false;
      branchInfo = branchDetails;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
      errorDialog(context, e.toString());
    }
  }
}
