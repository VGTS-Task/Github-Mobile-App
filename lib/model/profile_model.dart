import 'package:github_mobile_app/model/org_model.dart';

class ProfileModel {
  const ProfileModel({
    required this.id,
    required this.name,
    required this.imgURL,
    this.userName,
    this.orgDetails,
  });

  final int id;
  final String name;
  final String imgURL;
  final String? userName;
  final List<OrgDetails>? orgDetails;

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    List<OrgDetails> orgDetails = [];
    if (json["orgDetails"] != null) {
      List<dynamic> orgInfoJson = json["orgDetails"];
      for (var orgInfo in orgInfoJson) {
        orgDetails.add(OrgDetails.fromJson(orgInfo));
      }
    }

    return ProfileModel(
      id: json["id"],
      name: json["login"],
      userName: json["name"],
      imgURL: json["avatar_url"],
      orgDetails: orgDetails,
    );
  }

  ProfileModel copyWith({
    int? id,
    String? name,
    String? imgURL,
    String? userName,
    List<OrgDetails>? orgDetails,
  }) {
    return ProfileModel(
      id: id ?? this.id,
      name: name ?? this.name,
      imgURL: imgURL ?? this.imgURL,
      userName: userName ?? this.userName,
      orgDetails: orgDetails ?? this.orgDetails,
    );
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> orgInfoJson = [];
    if (orgDetails != null && orgDetails!.isNotEmpty) {
      for (var orgInfo in orgDetails!) {
        orgInfoJson.add(orgInfo.toJson());
      }
    }

    return {
      "id": id,
      "login": name,
      "name": userName,
      "avatar_url": imgURL,
      "orgDetails": orgInfoJson
    };
  }
}
