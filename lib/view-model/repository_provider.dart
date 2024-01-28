import 'package:flutter/material.dart';
import 'package:github_mobile_app/model/repository_model.dart';
import 'package:github_mobile_app/ui/screens/common/error_dialog.dart';
import 'package:github_mobile_app/view-model/http_service.dart';

class RepositoryProvider extends ChangeNotifier {
  bool isLoading = false;
  List<RepositoryModel> repositoryInfo = [];

  void getRepositopries(BuildContext context, String url, String token) async {
    try {
      isLoading = true;
      var reposList =
          await HttpService.getGithubResponse(context, url, token: token);
      List<RepositoryModel> reposDetails = [];
      if (reposList != null) {
        for (var resposInfo in reposList) {
          reposDetails.add(RepositoryModel.fromJson(resposInfo));
        }
      }

      isLoading = false;
      repositoryInfo = reposDetails;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
      errorDialog(context, e.toString());
    }
  }
}
