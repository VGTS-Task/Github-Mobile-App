import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:github_mobile_app/constants/string_constants.dart';
import 'package:github_mobile_app/model/profile_model.dart';
import 'package:github_mobile_app/view-model/http_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isLoading = false;
  ProfileModel? profileModel;

  void changeProfileInfo(ProfileModel newProfileInfo) {
    profileModel = newProfileInfo;
    notifyListeners();
  }

  getProfileInfoFromLocal() async {
    SharedPreferences localPreference = await SharedPreferences.getInstance();
    String? localAccessToken =
        localPreference.getString(StringConstants.profileKey);
    if (localAccessToken != null) {
      profileModel = ProfileModel.fromJson(jsonDecode(localAccessToken));
      notifyListeners();
    }
  }

  // void getRepos(context, String token) async {
  //   try {
  //     isLoading = true;
  //     var temp = await HttpService.getRepos(context, token: token);
  //     if (temp != null) {
  //       reposModel = temp;
  //     }
  //     isLoading = false;
  //     notifyListeners();
  //   } catch (e) {
  //     isLoading = false;
  //     notifyListeners();
  //     print(e.toString());
  //   }
  // }

  void getOrgs(context, String token) async {
    try {
      isLoading = true;
      var orgList = await HttpService.getOrgs(context, token: token);
      List<OrgDetails> orgDetails = [];
      if (orgList != null) {
        for (var orgInfo in orgList) {
          orgDetails.add(OrgDetails.fromJson(orgInfo));
        }
      }

      profileModel = profileModel?.copyWith(orgDetails: orgDetails);

      SharedPreferences localPreference = await SharedPreferences.getInstance();
      localPreference.setString(
          StringConstants.accessTokenKey, jsonEncode(profileModel!.toJson()));
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
      print(e.toString());
    }
  }
}
