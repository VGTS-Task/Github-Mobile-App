import 'package:flutter/material.dart';
import 'package:github_mobile_app/view-model/profile_provider.dart';
import 'package:provider/provider.dart';

class OrgDrawer extends StatefulWidget {
  const OrgDrawer({super.key});

  @override
  State<OrgDrawer> createState() => _OrgDrawerState();
}

class _OrgDrawerState extends State<OrgDrawer> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.75,
      child: ColoredBox(
        color: Colors.white,
        child: Consumer<ProfileProvider>(
          builder: (context, profileProvider, child) {
            return Column(
              children: [
                Row(
                  children: [
                    Image.network(profileProvider.profileModel!.imgURL)
                  ],
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
