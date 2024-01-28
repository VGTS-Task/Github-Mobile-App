import 'package:flutter/cupertino.dart' show showCupertinoDialog;
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:github_mobile_app/constants/api_base_url.dart';
import 'package:github_mobile_app/ui/screens/common/webview.dart';

Future loginDialog(context,
    {required String clientId, NavigationDelegate? navigationDelegate}) {
  Size size = MediaQuery.of(context).size;
  return showCupertinoDialog(
    context: context,
    builder: (BuildContext context) => SizedBox(
      height: size.height,
      width: size.width,
      child: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
        child: CommonWebview(
          clientId: clientId,
          navigationDelegate: navigationDelegate,
        ),
      ),
    ),
  );
}

Future logoutDialog(context, {NavigationDelegate? navigationDelegate}) {
  Size size = MediaQuery.of(context).size;
  return showCupertinoDialog(
    context: context,
    builder: (BuildContext context) => SizedBox(
      height: size.height,
      width: size.width,
      child: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
        child: WebView(
          initialUrl: APIUrl.logout,
          javascriptMode: JavascriptMode.unrestricted,
          navigationDelegate: navigationDelegate,
        ),
      ),
    ),
  );
}
