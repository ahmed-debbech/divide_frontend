import 'package:divide_frontend/models/division/DivItem.dart';

class Division {
  int? id;
  String? submissionTs;
  String? lastModTs;
  List<DivItem>? divisionItems;

  Division(){
    divisionItems = [];
  }
}
