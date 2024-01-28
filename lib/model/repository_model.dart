class RepositoryModel {
  const RepositoryModel({
    required this.id,
    required this.name,
    required this.ownerName,
    required this.branchURL,
    required this.createdTym,
    required this.orgImgURL,
    this.lastUpdatedTym,
    this.reposImgURL,
  });
  final int id;
  final String name;
  final String ownerName;
  final String branchURL;
  final String createdTym;
  final String? lastUpdatedTym;
  final String? reposImgURL;
  final String orgImgURL;

  factory RepositoryModel.fromJson(Map<String, dynamic> json) {
    return RepositoryModel(
      id: json["id"],
      name: json["name"],
      ownerName: json["owner"]["login"],
      branchURL: json["branches_url"],
      createdTym: json["created_at"],
      lastUpdatedTym: json["updated_at"],
      reposImgURL: json["avatar_url"],
      orgImgURL: json["owner"]["avatar_url"],
    );
  }
}
