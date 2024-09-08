import 'package:divide_frontend/models/division/Participant.dart';
import 'package:divide_frontend/services/division/DivisionManager.dart';
import 'package:divide_frontend/ui/common/division_popups/AddFriendPopup.dart';
import 'package:divide_frontend/ui/common/division_popups/AddNonExistingUserPopup.dart';
import 'package:divide_frontend/ui/common/division_popups/Person.dart';
import 'package:divide_frontend/ui/common/division_popups/PersonTile.dart';
import 'package:flutter/material.dart';

class EntryPopup extends StatelessWidget {
  List<Person> people = [];
  String name;
  double quantity;
  double unitPrice;
  double totalPrice;
  int receiptId;

  EntryPopup({
    required this.name,
    required this.totalPrice,
    required this.quantity,
    required this.unitPrice,
    required this.receiptId
  });


  @override
  void initState(){
    List<Participant> parts = DivisionManager().divisionRepresenter!.getAllParticipantsFor(receiptId);
    for(Participant p in parts){
      people.add(Person(name: p.nonExistingUserName!, amount: 0));
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: Text(this.name),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  TextSpan(
                    text: 'Total Amount: ',
                    children: [
                      TextSpan(
                        text: '${this.totalPrice}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Text('Quantity: ${this.quantity}'),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Text('Unit price: ${this.unitPrice}'),
          ),
          SizedBox(height: 25),
          Text('${people.length} people involved'),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.all(8),
            height: 150, // Adjust height as needed
            child: SingleChildScrollView(
              child: Column(
                children: people.map((person) {
                  return PersonTile(
                    person: person,
                    removePerson: (e) {},
                  );
                }).toList(),
              ),
            ),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) =>
                        AddNonExistingUserPopup(divId: receiptId),
                  );
                },
              ),
              IconButton(
                icon: Icon(Icons.person_add),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AddFriendPopup(),
                  );
                },
              ),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Done'),
        ),
      ],
    );
  }
}
