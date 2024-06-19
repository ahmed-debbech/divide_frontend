import 'package:divide_frontend/models/FriendshipRegistry.dart';
import 'package:divide_frontend/services/FriendshipService.dart';
import 'package:flutter/material.dart';

class MyFriendsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyFriendsPageState();
}

class _MyFriendsPageState extends State<MyFriendsPage> {
  List<FriendshipRegistry> _myFriends = [];

  late FriendshipService fs;

  @override
  void initState() {
    fs = FriendshipService(context: context);
    fs.getFriends().then((value) => {
          _myFriends = value,
        });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _myFriends.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Text(_myFriends[index].opposite.fullName),
                      const SizedBox(
                        width: 10,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            fs.unfriend(_myFriends[index].id);
                          },
                          child: const Text("Unfriend"),
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(color: Colors.blue)))))
                    ],
                  )),
            ),
            SizedBox(height: 20),
          ],
        );
      },
    );
  }
}
