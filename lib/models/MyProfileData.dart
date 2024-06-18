class MyProfileData{
  late String fullName;
  late String email;
  late String uid;

  MyProfileData({
    required this.fullName,
    required this.email,
    required this.uid
  });

  factory MyProfileData.fromJson(Map<String, dynamic> json) {
    return MyProfileData(
        fullName: json['fullName'],
        email: json['email'],
        uid: json['uid'],
    );
  }
}