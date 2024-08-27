import 'package:flutter/material.dart';



class Person {
  final String name;
  final int amount;

  Person({required this.name, required this.amount});
}

class CafeLatinoLattePopup extends StatelessWidget {
  final List<Person> people = [];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: Text('Cafe latino latte'),
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
                        text: '18000',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Text('Quantity: 2'),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Text('Unit price: 6000'),
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
                    removePerson: removePerson,
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
                        AddNonExistingUserPopup(addPerson: addPerson),
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

class AddNonExistingUserPopup extends StatefulWidget {
  final Function(String) addPerson;

  AddNonExistingUserPopup({required this.addPerson});

  @override
  _AddNonExistingUserPopupState createState() =>
      _AddNonExistingUserPopupState();
}

class _AddNonExistingUserPopupState extends State<AddNonExistingUserPopup> {
  String newName = '';

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
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(5),
            ),
            margin: EdgeInsets.symmetric(vertical: 4),
            child: ListTile(
              leading: CircleAvatar(
                child: Text('N'),
              ),
              title: Text('Name Surname'),
            ),
          ),
          SizedBox(height: 16),
          Align(
            alignment: Alignment.centerLeft,
            child: Text('New'),
          ),
          SizedBox(height: 8),
          TextField(
            decoration: InputDecoration(hintText: 'Name'),
            onChanged: (value) {
              setState(() {
                newName = value;
              });
            },
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
            widget.addPerson(newName);
            Navigator.pop(context);
          },
          child: Text('Done'),
        ),
      ],
    );
  }
}

class AddFriendPopup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: Text(
          'Add a friend',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(5),
              ),
              margin: EdgeInsets.symmetric(vertical: 4),
              child: ListTile(
                leading: CircleAvatar(
                  child: Text('M'),
                ),
                title: Text('Myself'),
              ),
            ),
            SizedBox(height: 16),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Your friends',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            SizedBox(height: 8),
            // Wrap the list of friends in a SizedBox to limit height
            SizedBox(
              height: 150, // Adjust height as needed
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildFriendTile('Idriss'),
                    _buildFriendTile('Ayadi'),
                    // Add more _buildFriendTile widgets for additional names
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
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

  Widget _buildFriendTile(String name) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(5),
      ),
      margin: EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(name[0]),
        ),
        title: Text(name),
      ),
    );
  }
}
