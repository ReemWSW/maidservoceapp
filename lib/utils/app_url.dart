class AppUrl {
  // static const String liveBaseURL = "https://miad-app.herokuapp.com";
  static const String localBaseURL = "http://10.0.2.2:3000";

  static const String baseURL = localBaseURL;
  static const String login = baseURL + "/login";
  static const String register = baseURL + "/register";

  static const String orderPost = baseURL + "/order";

  static const String setMaid = baseURL + "/setmaid";
}
