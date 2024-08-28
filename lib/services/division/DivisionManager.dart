import 'package:divide_frontend/models/Receipt.dart';
import 'package:divide_frontend/models/division/Division.dart';
import 'package:divide_frontend/services/division/DivisionRepresenter.dart';

class DivisionManager {
  static final DivisionManager _singleton = DivisionManager._internal();

  DivisionRepresenter? divisionRepresenter;

  factory DivisionManager() {
    return _singleton;
  }

  void createRepresenter(ReceiptDto rc) {
    divisionRepresenter = DivisionRepresenter(rc);
  }

  DivisionManager._internal();
}
