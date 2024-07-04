import 'package:flutter/material.dart';

class SingleItem extends StatefulWidget {
  String name;
  double total;
  double quantity = 0;
  double left = 0;
  int involvedPeople = 0;

  SingleItem(
      {super.key,
      required this.name,
      required this.quantity,
      required this.total});

  @override
  State<SingleItem> createState() => _SingleItemState();
}

class _SingleItemState extends State<SingleItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
            padding: EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                    softWrap: true,

                    "${widget.quantity}X ${widget.name}",
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
               
                const SizedBox(width: 30.0),
                Expanded(
                    child: Column(children: [
                  Text(
                    "total",
                    style: TextStyle(color: Color.fromRGBO(8, 192, 82, 1)),
                  ),
                  Text("left",
                      style: TextStyle(color: Color.fromRGBO(225, 38, 38, 1))),
                ])),
                const Spacer(flex: 1),
                Expanded(
                    child: Text("inv",
                        style: TextStyle(
                            color: Color.fromRGBO(132, 132, 132, 1)))),
                IconButton(
                  icon: Icon(Icons.link),
                  onPressed: () {},
                ),
              ],
            )));
  }
}
