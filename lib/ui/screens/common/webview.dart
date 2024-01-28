import 'package:flutter/material.dart';
import 'package:github_mobile_app/constants/api_base_url.dart';
import 'package:github_mobile_app/constants/color_constants.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CommonWebview extends StatefulWidget {
  const CommonWebview(
      {required this.clientId, this.navigationDelegate, super.key});

  final String clientId;
  final NavigationDelegate? navigationDelegate;

  @override
  State<CommonWebview> createState() => _CommonWebviewState();
}

class _CommonWebviewState extends State<CommonWebview> {
  int _currentPosition = 1;

  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      index: _currentPosition,
      children: [
        WebView(
          initialUrl: APIUrl.authorize(widget.clientId),
          javascriptMode: JavascriptMode.unrestricted,
          navigationDelegate: widget.navigationDelegate,
          onPageFinished: (url) {
            setState(() {
              _currentPosition = 0;
            });
          },
        ),
        const ColoredBox(
          color: Colors.white,
          child: Center(
            child: CircularProgressIndicator(
              color: ColorConstants.primary,
            ),
          ),
        ),
      ],
    );
  }
}
