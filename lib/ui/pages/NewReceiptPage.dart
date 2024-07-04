import 'package:divide_frontend/ui/common/SingleItem.dart';
import 'package:flutter/material.dart';

class NewReceiptPage extends StatefulWidget {
  late String id;

  NewReceiptPage({super.key, required this.id});

  @override
  State<NewReceiptPage> createState() => _NewReceiptPageState();
}

class _NewReceiptPageState extends State<NewReceiptPage> {
  @override
  void initState() {
    print("${widget.id}");
  }

  List<Widget> loadItems() {
    Widget w = SingleItem(name: "yiqehwgfdcuyghqwuyfed", quantity: 4, total: 10.0,);
    List<Widget> list = [];
    list.add(w);
    list.add(w);
    list.add(w);
    list.add(w);
    list.add(w);
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.only(top: 16.0),
                          child: Text(
                            'New Receipt',
                            style: TextStyle(
                              fontSize: 34,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                      Icon(Icons.cancel_rounded)
                    ],
                  ),
                  SizedBox(height: 16),
                  Container(
                    height: 200,
                    color: Colors.grey[300],
                    child: Center(child: Text('Picture')),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Place',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Total',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  SingleChildScrollView(
                    child: Column(
                      children: loadItems(),
                    ),
                  ),
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle validate action
                      },
                      child: Text('Validate'),
                      style: ElevatedButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      ),
                    ),
                  ),
                ]))));
  }
}
