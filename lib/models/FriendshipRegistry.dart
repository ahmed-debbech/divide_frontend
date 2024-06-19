class UserDto {
  late String uid;
  late String fullName;

  UserDto({required this.uid, required this.fullName});
}

class FriendshipRegistry {
  late int id;

  late UserDto from;
  late UserDto to;

  late UserDto opposite;

  FriendshipRegistry(
      {required this.id,
      required this.from,
      required this.to,
      required this.opposite});

  factory FriendshipRegistry.fromJson(Map<String, dynamic> json) {
    return FriendshipRegistry(
        from: UserDto(
            fullName: json['from']["fullName"], uid: json['from']['uid']),
        to: UserDto(fullName: json['to']["fullName"], uid: json['to']['uid']),
        id: json['id'],
        opposite: UserDto(
            fullName: json['opposite']["fullName"],
            uid: json['opposite']['uid']));
  }
}
