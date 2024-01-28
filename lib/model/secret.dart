class Secret {
  final String clientId, clientSecret;
  String? code;

  Secret({this.clientId = "", this.clientSecret = "", this.code = ""});

  factory Secret.fromJson(Map<String, dynamic> jsonMap) {
    return Secret(
        clientId: jsonMap["client_id"],
        clientSecret: jsonMap["client_secret"],
        code: jsonMap["code"]);
  }

  toJson() {
    return {
      "client_id": clientId,
      "client_secret": clientSecret,
      "code": code,
    };
  }
}
