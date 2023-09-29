class Response {
  final String name, question;
  final bool questionRequired;
  final dynamic data;

  const Response(
      {required this.name,
      required this.question,
      required this.questionRequired,
      required this.data});
}