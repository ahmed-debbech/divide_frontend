import 'package:divide_frontend/models/division/DivItem.dart';
import 'package:divide_frontend/models/division/Division.dart';
import 'package:divide_frontend/models/Receipt.dart';
import 'package:divide_frontend/globals.dart' as globals;
import 'package:divide_frontend/models/division/Participant.dart';

class DivisionRepresenter {
  Division division = Division();
  ReceiptDto? associatedReceipt;

  DivisionRepresenter(ReceiptDto receiptDto) {
    this.division = Division();
    this.associatedReceipt = receiptDto;
    initialize();
  }

  void initialize() {
    this.division.divisionItems = [];
    this.associatedReceipt!.receiptData!.lineItems?.forEach((element) {
      this.division.divisionItems!.add(DivItem());
    });
    int i = 0;
    this.division.divisionItems!.forEach((element) {
      element.receiptItem =
          associatedReceipt?.receiptData!.lineItems![i] as ReceiptItem;
      i++;
    });

    globals.logger.i(("DIVSION MODEL").toString());
    globals.logger.i((this.division).toString());
  }

  int getInvolvedPplForSingleItem(int id) {
    for (int i = 0; i <= division.divisionItems!.length - 1; i++) {
      DivItem di = this.division.divisionItems![i];
      if (di.receiptItem!.id == id) {
        return di.participantsList!.length;
      }
    }
    return 0;
  }
}
