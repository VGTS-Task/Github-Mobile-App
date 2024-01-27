import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:github_mobile_app/constants/string_constants.dart';
import 'package:github_mobile_app/model/secret.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginProvider extends ChangeNotifier {
  bool isLoading = false;
  Secret? secretKeys;
  String? accessToken;

  void updateSecretKey(String code) {
    secretKeys?.code = code;
    notifyListeners();
  }

  void updateAccessToken(String token) {
    accessToken = token;
    notifyListeners();
  }

  void loadKeys() async {
    secretKeys = await load('assets/json/secrets.json');
    notifyListeners();
  }

  Future<Secret> load(String secretPath) {
    return rootBundle.loadStructuredData<Secret>(secretPath, (jsonStr) async {
      final secret = Secret.fromJson(json.decode(jsonStr));
      return secret;
    });
  }

  getAccessTokenFromLocal() async {
    SharedPreferences localPreference = await SharedPreferences.getInstance();
    String? localAccessToken =
        localPreference.getString(StringConstants.accessTokenKey);
    if (localAccessToken != null) {
      accessToken = localAccessToken;
      notifyListeners();
    }
  }
}
