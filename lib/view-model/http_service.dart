import 'dart:convert';

import 'package:github_mobile_app/ui/screens/common/error_dialog.dart';
import 'package:http/http.dart' as http;

class HttpService {
  HttpService._();

  static Future<List<dynamic>?> getGithubResponse(context, String url,
      {required String token}) async {
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/vnd.github.v3+json',
        },
      );

      return jsonDecode(response.body);
    } catch (e) {
      errorDialog(context, "Failed to fetch data");
    }
    return null;
  }
}
