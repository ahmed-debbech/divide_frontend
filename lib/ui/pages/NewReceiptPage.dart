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

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(children: [
                  Row(
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
                  Image(
                    image: NetworkImage('https://example.com/image.jpg'),
                  )
                ]))));
  }
}
