import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:github_mobile_app/ui/screens/dashboard.dart';
import 'package:github_mobile_app/ui/screens/login.dart';
import 'package:github_mobile_app/view-model/login_provider.dart';

class LoginAuthentication extends StatefulWidget {
  const LoginAuthentication({super.key});

  @override
  State<LoginAuthentication> createState() => _LoginAuthenticationState();
}

class _LoginAuthenticationState extends State<LoginAuthentication> {
  @override
  void initState() {
    LoginProvider loginProvider =
        Provider.of<LoginProvider>(context, listen: false);
    loginProvider.loadKeys();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Login();
        }

        return const DashboardPage();
      },
    );
  }
}
