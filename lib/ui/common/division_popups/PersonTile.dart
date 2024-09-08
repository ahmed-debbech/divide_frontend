import 'package:divide_frontend/ui/common/division_popups/Person.dart';
import 'package:flutter/material.dart';

class PersonTile extends StatelessWidget {
  final Person person;
  final Function(Person) removePerson;

  PersonTile({required this.person, required this.removePerson});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(5),
      ),
      margin: EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        dense: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          child: Text(person.name[0]),
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                person.name,
                overflow: TextOverflow.visible,
                maxLines: 1,
                softWrap: false,
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(
                width:
                    16), // Adjust spacing between name and amount/delete icon
            Text(person.amount.toString()),
            SizedBox(width: 8), // Adjust spacing between amount and delete icon
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => removePerson(person),
            ),
          ],
        ),
      ),
    );
  }
}
