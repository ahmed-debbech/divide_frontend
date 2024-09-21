class Participant {
  int? id;
  User? registeredUser;
  String? nonExistingUserName;
  double? amount;
  double weight = 1;
  
  Participant(
      {this.id, this.registeredUser, this.nonExistingUserName, this.amount});
  @override
  String toString() {
    // Convert registeredUser to its string representation or 'null' if it is null
    String registeredUserString = registeredUser?.toString() ?? 'null';
    // Handle null values for other fields
    String nonExistingUserNameString = nonExistingUserName ?? 'null';
    String amountString = amount?.toString() ?? 'null';

    return 'Participant(id: $id, registeredUser: $registeredUserString, nonExistingUserName: $nonExistingUserNameString, amount: $amountString, weight: $weight)';
  }
}

class User {
  int? id;
  // Other fields can be added here

  User({this.id});
}
