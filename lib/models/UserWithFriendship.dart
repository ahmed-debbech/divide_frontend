class UserWithFriendship {
  late String uid;
  late String fullName;
  late String friendshipStatus;
  late int friendshipId;

  UserWithFriendship(
      {required this.uid,
      required this.fullName,
      required this.friendshipStatus,
      required this.friendshipId});

  factory UserWithFriendship.fromJson(Map<String, dynamic> json) {
    return UserWithFriendship(
        fullName: json['fullName'],
        friendshipStatus: json['friendshipStatus'],
        uid: json['uid'],
        friendshipId: json["friendshipId"]);
  }
}
