import 'dart:async';

import 'package:divide_frontend/services/division/DivisionManager.dart';
import 'package:divide_frontend/ui/common/division_popups/EntryPopup.dart';
import 'package:flutter/material.dart';
import 'package:divide_frontend/globals.dart' as globals;

class SingleItem extends StatefulWidget {
  String name;
  double total;
  double quantity = 0;
  int involvedPeople = 0;
  int receiptItemId = 0;

  SingleItem(
      {super.key,
      required this.name,
      required this.quantity,
      required this.total,
      required this.receiptItemId});

  @override
  State<SingleItem> createState() => _SingleItemState();
}

class _SingleItemState extends State<SingleItem> {
  void openDivisionPopup() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => EntryPopup(
                name: widget.name,
                totalPrice: widget.total,
                quantity: widget.quantity,
                unitPrice: 0,
                receiptId: widget.receiptItemId,
              )),
    );
  }

  @override
  void initState() {
    Timer(const Duration(seconds: 3), () {
      setState(() => widget.involvedPeople = DivisionManager()
          .divisionRepresenter!
          .getInvolvedPplForSingleItem(widget.receiptItemId));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 4.0,
        child: Padding(
            padding: EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 100,
                  child: Text(
                    softWrap: true,
                    overflow: TextOverflow.visible,
                    "${widget.name}",
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Spacer(),
                Expanded(
                    child: Column(children: [
                  Text(
                    widget.total.toString(),
                    style: TextStyle(
                        color: Color.fromRGBO(8, 192, 82, 1), fontSize: 12.0),
                  ),
                  Text("X${widget.quantity.toString()}",
                      style: TextStyle(
                          color: Color.fromRGBO(225, 38, 38, 1),
                          fontSize: 12.0)),
                ])),
                const SizedBox(width: 8.0),
                Expanded(
                    child: Text("${widget.involvedPeople} people",
                        style: TextStyle(
                            color: Color.fromRGBO(132, 132, 132, 1)))),
                const SizedBox(width: 8.0),
                IconButton(
                  icon: Icon(Icons.link),
                  onPressed: () {
                    openDivisionPopup();
                  },
                ),
              ],
            )));
  }
}
