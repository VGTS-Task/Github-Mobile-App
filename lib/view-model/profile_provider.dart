import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:github_mobile_app/constants/api_base_url.dart';
import 'package:github_mobile_app/constants/string_constants.dart';
import 'package:github_mobile_app/model/org_model.dart';
import 'package:github_mobile_app/model/profile_model.dart';
import 'package:github_mobile_app/ui/screens/common/error_dialog.dart';
import 'package:github_mobile_app/view-model/http_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileProvider extends ChangeNotifier {
  bool isLoading = false;
  ProfileModel? profileModel;
  int orgSelectedIndex = 0;

  void changeProfileInfo(ProfileModel newProfileInfo) async {
    profileModel = newProfileInfo;
    SharedPreferences localPreference = await SharedPreferences.getInstance();
    localPreference.setString(
        StringConstants.profileKey, jsonEncode(profileModel!.toJson()));
    notifyListeners();
  }

  void changeOrgSelectedIndex(int index, BuildContext context) {
    orgSelectedIndex = index;
    Navigator.of(context).pop();
    notifyListeners();
  }

  getProfileInfoFromLocal() async {
    SharedPreferences localPreference = await SharedPreferences.getInstance();
    String? localProfileInfo =
        localPreference.getString(StringConstants.profileKey);
    if (localProfileInfo != null) {
      profileModel = ProfileModel.fromJson(jsonDecode(localProfileInfo));
      notifyListeners();
    }
  }

  void getOrgs(context, String token) async {
    try {
      isLoading = true;
      var orgList = await HttpService.getGithubResponse(context, APIUrl.orgs,
          token: token);
      List<OrgDetails> orgDetails = [];
      if (orgList != null) {
        for (var orgInfo in orgList) {
          orgDetails.add(OrgDetails.fromJson(orgInfo));
        }
      }

      profileModel = profileModel?.copyWith(orgDetails: orgDetails);
      SharedPreferences localPreference = await SharedPreferences.getInstance();
      localPreference.setString(
          StringConstants.profileKey, jsonEncode(profileModel!.toJson()));
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
      errorDialog(context, e.toString());
    }
  }
}
