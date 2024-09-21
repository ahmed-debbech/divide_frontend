import 'package:divide_frontend/services/division/DivisionManager.dart';
import 'package:flutter/material.dart';

class AddNonExistingUserPopup extends StatefulWidget {

  int divId;


  AddNonExistingUserPopup({required this.divId});

  @override
  _AddNonExistingUserPopupState createState() =>
      _AddNonExistingUserPopupState();
}

class _AddNonExistingUserPopupState extends State<AddNonExistingUserPopup> {
  String newName = '';
  List<String> listOfNonExisting = [];
  final TextEditingController control = TextEditingController();

  @override
  void initState() {
    setState(() {
      listOfNonExisting =
          DivisionManager().divisionRepresenter!.getListOfAllNonExistingUsers();
    });
  }


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: Text('Add a non-existing user'),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text('Existing'),
          ),
          SizedBox(height: 8),
          SizedBox(
              height: 150, // Adjust height as needed
              child: SingleChildScrollView(
                child: Column(
                  children: buildList(context, widget.divId)))),
          SizedBox(height: 16),
          Align(
            alignment: Alignment.centerLeft,
            child: Text('New'),
          ),
          SizedBox(height: 8),
          TextField(
            decoration: InputDecoration(hintText: 'Name'),
            controller: control
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            setState(() {
              listOfNonExisting.add(control.text);
              newName = control.text;
              control.text = "";
            });
          },
          child: Text('Add'),
        ),
      ],
    );
  }

  List<Widget> buildList(BuildContext context, int divId) {
    List<Widget> wid = [];
    for (int i = 0; i <= listOfNonExisting.length - 1; i++) {
      wid.add(Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5),
        ),
        margin: EdgeInsets.symmetric(vertical: 4),
        child: ListTile(
          leading: CircleAvatar(
            child: Text(listOfNonExisting[i][0]),
          ),
          title: Text(listOfNonExisting[i]),
          onTap: (){
            DivisionManager().divisionRepresenter!.addNonExistingUser(divId, listOfNonExisting[i]);
            Navigator.pop(context);
          },
        ),
      ));
    }
    return wid;
  }
}
