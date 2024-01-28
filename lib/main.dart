import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:github_mobile_app/constants/color_constants.dart';
import 'package:github_mobile_app/firebase_options.dart';
import 'package:github_mobile_app/ui/screens/login_authentication.dart';
import 'package:github_mobile_app/view-model/branch_provider.dart';
import 'package:github_mobile_app/view-model/profile_provider.dart';
import 'package:github_mobile_app/view-model/login_provider.dart';
import 'package:github_mobile_app/view-model/repository_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(create: (_) => RepositoryProvider()),
        ChangeNotifierProvider(create: (_) => BranchProvider())
      ],
      child: MaterialApp(
        title: 'Github Mobile App',
        theme: ThemeData(
            appBarTheme:
                const AppBarTheme(color: ColorConstants.primary, elevation: 0),
            colorScheme:
                ColorScheme.fromSeed(seedColor: ColorConstants.primary),
            scaffoldBackgroundColor: Colors.white),
        home: const LoginAuthentication(),
      ),
    );
  }
}
