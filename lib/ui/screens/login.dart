import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:github_mobile_app/constants/app_dimensions.dart';
import 'package:github_mobile_app/constants/color_constants.dart';
import 'package:github_mobile_app/constants/string_constants.dart';
import 'package:github_mobile_app/ui/screens/common/authentication_dialog.dart';
import 'package:github_mobile_app/view-model/login_provider.dart';
import 'package:github_mobile_app/view-model/authentication.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  _onSigninButtonClicked() async {
    LoginProvider loginProvider =
        Provider.of<LoginProvider>(context, listen: false);
    await loginDialog(context,
        clientId: loginProvider.secretKeys!.clientId,
        navigationDelegate: (request) =>
            Authentication.handleWebviewNavigation(context, request));
  }

  @override
  Widget build(BuildContext context) {
    EdgeInsets screenPadding = MediaQuery.of(context).viewPadding;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          top: AppDimensions.paddingXXLarge + screenPadding.top,
          bottom: AppDimensions.paddingXXLarge + screenPadding.bottom,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/github_logo.png",
                  filterQuality: FilterQuality.high,
                  height: 60,
                  width: 60,
                ),
                Image.asset(
                  "assets/images/github_text.png",
                  filterQuality: FilterQuality.high,
                  height: 60,
                ),
              ],
            ),
            SvgPicture.asset("assets/images/login_info.svg"),
            SizedBox(
              height: 48,
              width: 300,
              child: ElevatedButton(
                onPressed: _onSigninButtonClicked,
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        ColorConstants.signinButtonColor),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(AppDimensions.radiusSM)))),
                child: const Text(StringConstants.signin),
              ),
            )
          ],
        ),
      ),
    );
  }
}
