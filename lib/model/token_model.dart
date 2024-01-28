class TokenModel {
  String accessToken;
  String tokenType;
  String scope;

  TokenModel(
      {required this.accessToken,
      required this.tokenType,
      required this.scope});

  factory TokenModel.fromJson(Map<String, dynamic> json) {
    return TokenModel(
      accessToken: json['access_token'],
      tokenType: json['token_type'],
      scope: json['scope'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['access_token'] = accessToken;
    data['token_type'] = tokenType;
    data['scope'] = scope;
    return data;
  }
}
