class OrgDetails {
  const OrgDetails({
    required this.id,
    required this.name,
    required this.orgImgURL,
    required this.reposURL,
  });
  final int id;
  final String name;
  final String orgImgURL;
  final String reposURL;

  factory OrgDetails.fromJson(Map<String, dynamic> json) {
    return OrgDetails(
      id: json["id"],
      name: json["login"],
      orgImgURL: json["avatar_url"],
      reposURL: json["repos_url"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "login": name,
      "avatar_url": orgImgURL,
      "repos_url": reposURL
    };
  }
}
