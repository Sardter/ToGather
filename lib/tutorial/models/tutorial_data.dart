class SylvestTutorialData {
  final bool kvkkAgreed;
  final bool eulaAgreed;
  final bool introCompleted;

  const SylvestTutorialData(
      {this.kvkkAgreed = false,
      this.eulaAgreed = false,
      this.introCompleted = false});

  factory SylvestTutorialData.fromJson(Map<String, dynamic> json) {
    return SylvestTutorialData(
        kvkkAgreed: json['kvkk'],
        eulaAgreed: json['eula'],
        introCompleted: json['intro']);
  }

  Map<String, dynamic> toJson() {
    return {'kvkk': kvkkAgreed, 'eula': eulaAgreed, 'intro': introCompleted};
  }
}