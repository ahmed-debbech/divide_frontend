import 'package:divide_frontend/models/Receipt.dart';
import 'package:divide_frontend/models/division/Participant.dart';

class DivItem {
  int? id;
  List<Participant>? participantsList;
  ReceiptItem? receiptItem;

  DivItem({this.id, this.participantsList, this.receiptItem}) {
    participantsList = [];
  }

  @override
  String toString() {
    // Convert participantsList and receiptItem to string representations
    String participantsString = participantsList != null
        ? participantsList!.map((p) => p.toString()).join(', ')
        : '[]';
    String receiptItemString = receiptItem?.toString() ?? 'null';

    return 'DivItem(id: $id, participantsList: [$participantsString], receiptItem: $receiptItemString)';
  }
}
