class APIUrl {
  static const String host = "https://github.com";
  static const String host2 = "https://api.github.com";

  //user
  static const String user = "$host2/user";
  static const String orgs = "$user/orgs";
  static const String getUserRepo = "$user/repos";

  //login authorization
  static const String login = "$host/login";
  static const String logout = "$host/logout";
  static const String oauth = "$login/oauth";
  static const String accessToken = "$oauth/access_token";

  static String authorize(clientId) =>
      "$oauth/authorize?client_id=$clientId&scope=read:org";
}
