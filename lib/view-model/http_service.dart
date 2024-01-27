import 'dart:convert';

import 'package:github_mobile_app/ui/screens/common/error_dialog.dart';
import 'package:http/http.dart' as http;

class HttpService {
  HttpService._();
  // static Future<ReposListModel?> getRepos(context,
  //     {required String token}) async {
  //   try {
  //     var headers = {
  //       'Authorization': "Bearer $token",
  //       'Content-type': 'application/json;charset=UTF-8',
  //       'Accept': 'application/json',
  //     };

  //     var response =
  //         await http.get(Uri.parse(APIUrl.getUserRepo), headers: headers);
  //     if (response.body.contains('followers_url')) {
  //       return ReposListModel.fromJson(
  //           json.decode('{"data":${response.body}}'));
  //     } else {
  //       errorDialog(context, "UNAUTHENTICATED");
  //     }
  //   } catch (e) {
  //     errorDialog(context, "Failed to fetch repositories");
  //   }
  //   return null;
  // }

  static Future<List<dynamic>?> getOrgs(context,
      {required String token}) async {
    try {
      const String apiUrl = 'https://api.github.com/user/orgs';
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/vnd.github.v3+json',
        },
      );

      return jsonDecode(response.body);
    } catch (e) {
      errorDialog(context, "Failed to fetch organisation");
    }
    return null;
  }
}
