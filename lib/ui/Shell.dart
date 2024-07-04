import 'dart:async';

import 'package:divide_frontend/ui/common/TakePhoto.dart';
import 'package:divide_frontend/ui/pages/FindFriendsPage.dart';
import 'package:divide_frontend/ui/pages/MyFriendsPage.dart';
import 'package:divide_frontend/ui/pages/MyProfilePage.dart';
import 'package:divide_frontend/ui/pages/MyReceiptsPage.dart';
import 'package:divide_frontend/ui/pages/MyFriendsPage.dart';
import 'package:divide_frontend/ui/common/ButtomNavigationButton.dart';
import 'package:divide_frontend/ui/pages/NewReceiptPage.dart';
import 'package:divide_frontend/ui/pages/ScanReceiptPage.dart';
import 'package:flutter/material.dart';

class Shell extends StatefulWidget {
  @override
  _ShellState createState() => _ShellState();
}

class _ShellState extends State<Shell> {
  String current_selection = "My Receipts";
  int selected_index = 0;

  int _clickCounter = 0;
  Timer? _clickTimer;

  @override
  void initState() {
    current_selection = "My Receipts";
    selected_index = 0;
  }

  @override
  void dispose() {
    _clickTimer?.cancel();
    super.dispose();
  }

  void _onDoubleClick() {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => NewReceiptPage(
                id: "STZL9",
              )),
    );
    /*TakePhoto().capture().then((value) => {
          //contains the base64 image
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ScanReceiptPage(base64Img: value)),
          )
        });*/
  }

  void _handleClick() {
    if (_clickCounter == 0) {
      _clickCounter++;
      _clickTimer = Timer(Duration(milliseconds: 300), () {
        _clickCounter = 0;
      });
    } else {
      _clickCounter = 0;
      _clickTimer?.cancel();
      _onDoubleClick();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(top: 16.0),
                child: Text(
                  '${current_selection}',
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
            Expanded(
                flex: 8,
                child: (this.selected_index == 0)
                    ? MyReceiptsPage()
                    : (this.selected_index == 2)
                        ? MyProfilePage()
                        : (this.selected_index == 1)
                            ? FindFriendsPage()
                            : (this.selected_index == -2)
                                ? MyFriendsPage()
                                : Container()),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BottomNavigationButton(
                  label: '', //my friends
                  icon: Icons.people_alt_rounded,
                  onPressedButton: () {
                    setState(() {
                      this.current_selection = "My Friends";
                      this.selected_index = -2;
                    });
                  },
                ),
                BottomNavigationButton(
                  label: '', //incomming requests
                  icon: Icons.notification_important_rounded,
                  onPressedButton: () {
                    setState(() {
                      this.current_selection = "Incomming Receipts";
                      this.selected_index = -1;
                    });
                  },
                ),
                SizedBox(
                  width: 50,
                  height: 50,
                  child: FloatingActionButton(
                    onPressed: () {
                      setState(() {
                        this.current_selection = "My Receipts";
                        this.selected_index = 0;
                      });
                      _handleClick();
                    },
                    child: Icon(Icons.camera_alt),
                  ),
                ),
                BottomNavigationButton(
                  label: '', //find friends
                  icon: Icons.search_rounded,
                  onPressedButton: () {
                    setState(() {
                      this.current_selection = "Find Friends";
                      this.selected_index = 1;
                    });
                  },
                ),
                BottomNavigationButton(
                  label: '', //my profile
                  icon: Icons.person_2_rounded,
                  onPressedButton: () {
                    setState(() {
                      this.current_selection = "My Profile";
                      this.selected_index = 2;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
