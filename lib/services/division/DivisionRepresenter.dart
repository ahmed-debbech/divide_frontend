import 'package:divide_frontend/models/division/Division.dart';

class DivisionRepresenter{

  bool isProcessing = false;
  Division division = Division();
  
  DivisionRepresenter(){
    isProcessing = false;
    this.division = Division();
  }

  int getInvolvedPplForSingleItem(int id){
    return 0;
  }
}