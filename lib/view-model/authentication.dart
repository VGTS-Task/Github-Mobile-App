import 'dart:async';
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:github_mobile_app/model/login_response_model.dart';
import 'package:github_mobile_app/constants/string_constants.dart';
import 'package:github_mobile_app/model/profile_model.dart';
import 'package:github_mobile_app/model/secret.dart';
import 'package:github_mobile_app/ui/screens/common/error_dialog.dart';
import 'package:github_mobile_app/view-model/login_provider.dart';
import 'package:github_mobile_app/view-model/profile_provider.dart';

class Authentication {
  Authentication._();

  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<UserCredential> loginWithGitHub(
      LoginProvider loginProvider) async {
    Secret secretKeys = loginProvider.secretKeys!;
    final response = await http.post(
      Uri.parse("https://github.com/login/oauth/access_token"),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json"
      },
      body: jsonEncode(GitHubLoginRequest(
        clientId: secretKeys.clientId,
        clientSecret: secretKeys.clientSecret,
        code: secretKeys.code!,
      )),
    );

    GitHubLoginResponse loginResponse =
        GitHubLoginResponse.fromJson(json.decode(response.body));
    final AuthCredential credential = GithubAuthProvider.credential(
      loginResponse.accessToken,
    );

    loginProvider.updateAccessToken(loginResponse.accessToken);

    SharedPreferences localPrefrence = await SharedPreferences.getInstance();
    localPrefrence.setString(
        StringConstants.accessTokenKey, loginResponse.accessToken);
    final UserCredential user =
        await FirebaseAuth.instance.signInWithCredential(credential);

    return user;
  }

  static Future<void> signInWithGitHub(
    BuildContext context,
    LoginProvider loginProvider,
  ) async {
    try {
      UserCredential userCredential = await loginWithGitHub(loginProvider);
      final AdditionalUserInfo? user = userCredential.additionalUserInfo;
      if (context.mounted) {
        if (user != null && user.profile != null) {
          ProfileProvider profileProvider =
              Provider.of<ProfileProvider>(context, listen: false);
          Navigator.pop(context);
          profileProvider
              .changeProfileInfo(ProfileModel.fromJson(user.profile!));
        } else {
          errorDialog(context, "Error signing in with GitHub");
        }
      }
    } catch (e) {
      errorDialog(context, "Error signing in with GitHub: $e");
    }
  }

  static Future<void> signOut() async {
    await _auth.signOut();
  }

  static FutureOr<NavigationDecision> handleWebviewNavigation(
      BuildContext context, NavigationRequest request) async {
    String url = request.url;

    try {
      if (url.toLowerCase().contains('?cancelled=true')) {
        return NavigationDecision.prevent;
      } else if (url.toLowerCase().contains('handler?code')) {
        LoginProvider loginProvider =
            Provider.of<LoginProvider>(context, listen: false);
        loginProvider.updateSecretKey(url.replaceAll(
            'https://github-mobile-app.firebaseapp.com/__/auth/handler?code=',
            ''));
        signInWithGitHub(context, loginProvider);
        return NavigationDecision.prevent;
      } else if (url == "https://github.com/") {
        Navigator.pop(context);
        Authentication.signOut();
        return NavigationDecision.prevent;
      } else {
        return NavigationDecision.navigate;
      }
    } catch (e) {
      return NavigationDecision.navigate;
    }
  }
}
