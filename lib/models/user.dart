class User {
  String sessionId;
  String? datetime;
  bool? isCitizen;
  String email;
  String? name;
  String? disability;
  bool isStaff;

  User(
      {required this.sessionId,
      this.datetime,
      this.isCitizen,
      required this.email,
      required this.isStaff,
      this.disability,
      this.name});
}
