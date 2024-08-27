class Participant {
  int? id;
  User? registeredUser;
  String? nonExistingUserName;
  double? amount;

  Participant({this.id, this.registeredUser, this.nonExistingUserName, this.amount});
}

class User {
  int? id;
  // Other fields can be added here

  User({this.id});
}