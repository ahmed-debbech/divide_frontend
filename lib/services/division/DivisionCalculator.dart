import 'package:divide_frontend/models/division/DivItem.dart';
import 'package:divide_frontend/models/division/Division.dart';
import 'package:divide_frontend/models/division/Participant.dart';

class DivisionCalculator{

  void update(Division division){
    division.divisionItems!.forEach((div) {
      _calculate(div);
    });
  }

  void _calculate(DivItem div){
    double total = _countWeights(div.participantsList!);
    _distributeByWeight(div.participantsList!, div.receiptItem!.total!, total);
  }

  double _countWeights(List<Participant> participants){
    double res= 0;
    for(int i =0; i<=participants.length-1; i++){
      res += participants[i].weight;
    }
    return res;
  }

  void _distributeByWeight(List<Participant> participants, double totalAmount, double totalWeigth) {
    for(int i =0; i<=participants.length-1; i++){
      participants[i].amount = (participants[i].weight / totalWeigth) * totalAmount;
    }
  }
}