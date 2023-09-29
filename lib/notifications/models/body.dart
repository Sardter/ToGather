class PushNotificationBody {
  final String? user;
  final String? event;
  final DateTime? startDate;
  final String? club;

  const PushNotificationBody(
      {required this.user,
      required this.event,
      required this.startDate,
      required this.club});

  factory PushNotificationBody.fromJson(Map json) {
    return PushNotificationBody(
        user: json['user'],
        event: json['event'],
        startDate: json['start_date'],
        club: json['club']);
  }
}
