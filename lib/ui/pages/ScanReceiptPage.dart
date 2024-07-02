import 'dart:async';
import 'dart:convert';
import 'dart:ffi';

import 'package:divide_frontend/services/ReceiptService.dart';
import 'package:divide_frontend/ui/common/dialog.dart';
import 'package:divide_frontend/ui/pages/NewReceiptPage.dart';
import 'package:flutter/material.dart';

class ScanReceiptPage extends StatefulWidget {
  final String base64Img;
  String? receiptReturnedId;
  bool hasFinishedProcessing = false;

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
              {
                setState(() {
                  widget.receiptReturnedId = value.data["processingAuthCode"];
                }),
                Timer.periodic(Duration(seconds: 1), (Timer t) {
                  receiptService
                      .checkProgress(widget.receiptReturnedId!)
                      .then((v) => {
                            if (v.ok)
                              {
                                print(v.data["ready"]),
                                if (v.data["ready"] as bool == true)
                                  {
                                    setState(() =>
                                        {widget.hasFinishedProcessing = true}),
                                    t.cancel(),
                                    Timer(const Duration(seconds: 3), () {
                                      Navigator.pop(context);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const NewReceiptPage()),
                                      );
                                    })
                                  }
                              }
                            else
                              {
                                t.cancel(),
                                setState(() =>
                                    {widget.hasFinishedProcessing = false}),
                                showCustomDialog(
                                    title: "Something went wrong",
                                    content:
                                        "It looks like that we are having a problem analyzing your request.",
                                    context: context,
                                    buttonText: "Ok",
                                    onPressed: () {
                                      Navigator.pop(context);
                                    })
                              }
                          });
                })
              }
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
                        ((widget.receiptReturnedId == null) &&
                                (widget.hasFinishedProcessing == false))
                            ? const Text(
                                'Rceipt is getting uploaded! please wait',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black))
                            : ((widget.receiptReturnedId != null) &&
                                    (widget.hasFinishedProcessing == false))
                                ? Text(
                                    "Uploaded succesfully! now the receipt is getting analyzed..." +
                                        "(${widget.receiptReturnedId})")
                                : ((widget.hasFinishedProcessing == true) &&
                                        (widget.receiptReturnedId != null))
                                    ? Text(
                                        "Successfully analyzed your request (${widget.receiptReturnedId})")
                                    : Container()
                      ]),
                    const SizedBox(height: 20),
                  ],
                ))));
  }
}
