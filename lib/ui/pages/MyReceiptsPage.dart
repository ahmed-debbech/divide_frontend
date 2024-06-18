import 'package:divide_frontend/ui/common/ButtomNavigationButton.dart';
import 'package:flutter/material.dart';

class MyReceiptsPage extends StatefulWidget {
  @override
  _ReceiptsPageState createState() => _ReceiptsPageState();
}

class _ReceiptsPageState extends State<MyReceiptsPage> {
  final List<Widget> _receipts =
      []; //List.generate(100, (index) => Text("hey"));

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _receipts.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            _receipts[index],
            SizedBox(height: 20),
          ],
        );
      },
    );
  }
}
