import 'dart:convert';

import 'package:divide_frontend/services/ReceiptService.dart';
import 'package:flutter/material.dart';

class ScanReceiptPage extends StatefulWidget {
  final String base64Img;
  String? receiptReturnedId;

  ScanReceiptPage({super.key, required this.base64Img, this.receiptReturnedId});

  @override
  State<StatefulWidget> createState() => _ScanReceiptPageState();
}

class _ScanReceiptPageState extends State<ScanReceiptPage> {
  late ReceiptService receiptService;

  @override
  void initState() {
    receiptService = ReceiptService(context: context);
    if (widget.base64Img != "") {
      print(widget.base64Img);
      receiptService.sendDataToScan(widget.base64Img).then((value) => {
            if (value.ok)
              setState(() {
                widget.receiptReturnedId = value.data["processingAuthCode"];
              })
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.only(top: 16.0),
                        child: Text(
                          'Scanning',
                          style: TextStyle(
                            fontSize: 34,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                    if (widget.base64Img == "") Text('No picture was selected'),
                    if (widget.base64Img != "")
                      Column(children: [
                        const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(),
                              SizedBox(height: 20),
                            ],
                          ),
                        ),
                        (widget.receiptReturnedId == null)
                            ? const Text(
                                'Rceipt is getting uploaded! please wait',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black))
                            : Text(
                                "Uploaded succesfully! now the receipt is getting analyzed..." +
                                    "(${widget.receiptReturnedId})")
                      ]),
                    const SizedBox(height: 20),
                  ],
                ))));
  }
}
