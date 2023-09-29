import 'package:ToGather/config/env.dart';

class URLManager {
  static String get apiRoot => Env.API_URL + "/api/";
  //static String get mediaRoot => Env.S3_URL + "/files/sylvest-media?path=";
  //static String get languagesRoot => Env.S3_URL + "/languages";

  static String get posts => apiRoot + "posts/";
  static String get comments => apiRoot + "comments/";
  static String get events => apiRoot + "events/";
  static String get categories => apiRoot + "categories/";
  static String get clubs => apiRoot + "clubs/";
  static String get places => apiRoot + "places/";
  static String get users => apiRoot + "users/";
  static String get formResponses => events + "forms/";
  static String get tags => apiRoot + "tags/";
  static String get universities => apiRoot + "universities/";

  static String get myProfile => users + "me/";
  static String get myLocation => myProfile + "location/";
  static String get notifications => myProfile + "notifications/";
  static String get notificationsCount => notifications + "count/";
  static String get blocks => myProfile + "blocks/";
  static String get myReports => myProfile + "reports/";
  static String get myHides => myProfile + "hides/";
  static String get connectionsReceived => myProfile + "connections/received/";
  static String get connectionsSent => myProfile + "connections/sent/";


  static String userProfile(int userId) => users + "$userId/";
  static String userClubs(int userId) => users + "$userId/clubs/";
  static String userConnect(int userId) => users + "$userId/connect/";
  static String userDisconnect(int userId) => users + "$userId/disconnect/";
  static String userBlock(int userId) => users + "$userId/block/";

  static String advertisements(int placeId) => places + "$placeId/advertisements/";
  static String placeAdmins(int placeId) => places + "$placeId/owners/";

  static String posRate(int postId) => posts + "$postId/rate/";

  static String commenRate(int commentId) => comments + "$commentId/rate/";

  static String eventAttend(int eventId) => events + "$eventId/attend/";
  static String eventVerifyUser(int eventId, int userId) => events + "$eventId/verify_user/$userId/";
  static String eventVerify(int eventId) => events + "$eventId/verify/";
  static String eventRate(int eventId) => events + "$eventId/rate/";

  static String clubJoin(int clubId) => clubs + "$clubId/join/";
  static String clubBanUser(int clubId) => clubs + "$clubId/ban_user/";
  static String clubChangeUserRole(int clubId) =>
      clubs + "$clubId/change_user_role/";

  static String get hides => apiRoot + "hides/";
  static String get report => apiRoot + "report/";

  static String get fcm => apiRoot + "fcm/";

  static String get auth => apiRoot + "auth/";

  static String get login => auth + "login/";
  static String get logout => auth + "logout/";
  static String get register => auth + "register/";
  static String get passwordReset => auth + "password/reset/";
  static String get device => auth + "device/";
  static String get token => auth + "token/";
  static String get tokenRefresh => token + "refresh-token/";

  static String get unreadReset => users + "unread_reset/";

  //static String get publicMedia => mediaRoot + "public/";
  //static String get defaultMedia =>
  //    "https://sylvest-media.fra1.digitaloceanspaces.com/default/";
}
