import 'package:divide_frontend/models/division/Participant.dart';

class DivItem {
  int? id;
  List<Participant>? participantsList;
  ReceiptItem? receiptItem;

  DivItem({this.id, this.participantsList, this.receiptItem});
}

class ReceiptItem {
  int? id;
  // Other fields can be added here

  ReceiptItem({this.id});
}