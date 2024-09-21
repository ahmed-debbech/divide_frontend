import 'package:divide_frontend/models/division/DivItem.dart';
import 'package:divide_frontend/models/division/Division.dart';
import 'package:divide_frontend/models/Receipt.dart';
import 'package:divide_frontend/globals.dart' as globals;
import 'package:divide_frontend/models/division/Participant.dart';
import 'package:divide_frontend/services/division/DivisionCalculator.dart';
import 'package:divide_frontend/ui/common/division_popups/AddNonExistingUserPopup.dart';

class DivisionRepresenter {
  Division division = Division();
  ReceiptDto? associatedReceipt;
  DivisionCalculator calculator = new DivisionCalculator();

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

    globals.logger.i(("DIVSION MODEL INIT").toString());
    globals.logger.i((this.division).toString());
  }

  /** public */
  int getInvolvedPplForSingleItem(int id) {
    for (int i = 0; i <= division.divisionItems!.length - 1; i++) {
      DivItem di = this.division.divisionItems![i];
      if (di.receiptItem!.id == id) {
        return di.participantsList!.length;
      }
    }
    return 0;
  }

  /** public */
  List<String> getListOfAllNonExistingUsers(){
    Set<String> nonexisting = {};
    for(int i =0; i<=division.divisionItems!.length-1; i++){
      DivItem di = this.division.divisionItems![i];

      for(int j=0; j<=di.participantsList!.length-1; j++){
        if(di.participantsList![j].nonExistingUserName != null){
          nonexisting.add(di.participantsList![j].nonExistingUserName!);
        }
      }
    }

    return nonexisting.toList();
  }

  /** public */
  void addNonExistingUser(int divId, String newUser){
    _setNewNonExistingUser(divId, newUser);
    this.calculator.update(this.division);
  }

  void _setNewNonExistingUser(int divId, String newUser){
    List<DivItem> di = division.divisionItems!;
    for(int i = 0; i<=division.divisionItems!.length-1; i++){

      if(division.divisionItems![i].receiptItem!.id == divId){

        if(getAllParticipantsFor(divId).where((element) => element.nonExistingUserName == newUser).toList().isEmpty){
          division.divisionItems![i].participantsList!.add(Participant(id: null, registeredUser: null,
          nonExistingUserName: newUser, amount: 0));

        }else{
          int participantIndexToUpdate = getAllParticipantsFor(divId).indexWhere(
            (element) => element.nonExistingUserName == newUser);
          Participant indexedParticipant = division.divisionItems![i].participantsList![participantIndexToUpdate];
          indexedParticipant.weight++;
        }
        break;
      }
    }

  }

  /** public */
  List<Participant> getAllParticipantsFor(int receiptId) {
    globals.logger.i((this.division).toString());
    for(DivItem di in division.divisionItems!){
      if(di.receiptItem!.id == receiptId){
        return di.participantsList!;
      }
    }
    return [];
  }

}
