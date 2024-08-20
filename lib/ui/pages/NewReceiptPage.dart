import 'dart:convert';

import 'package:divide_frontend/models/FriendshipRegistry.dart';
import 'package:divide_frontend/models/Receipt.dart';
import 'package:divide_frontend/models/ResponseHolder.dart';
import 'package:divide_frontend/services/FriendshipService.dart';
import 'package:divide_frontend/services/ReceiptService.dart';
import 'package:divide_frontend/ui/common/SingleItem.dart';
import 'package:divide_frontend/ui/common/dialog.dart';
import 'package:flutter/material.dart';
import 'package:divide_frontend/globals.dart' as globals;
import 'package:intl/intl.dart';

class NewReceiptPage extends StatefulWidget {
  late String id;

  NewReceiptPage({super.key, required this.id});

  @override
  State<NewReceiptPage> createState() => _NewReceiptPageState();
}

class _NewReceiptPageState extends State<NewReceiptPage> {
  late ReceiptService receiptService;
  late FriendshipService friendshipService;
  List<FriendshipRegistry> friends = [];

  ReceiptDto? receiptDto = null;

  Future<ResponseHolder?> tryGetOne(int numberOfTimes) async {
    ResponseHolder k;
    do {
      k = await receiptService.getOne(widget.id);
      numberOfTimes--;
    } while ((numberOfTimes != 0) && (!k.ok));

    if (numberOfTimes <= 0) return null;

    if (k.ok) {
      return k;
    } else {
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    ReceiptItem ri = ReceiptItem(id: 0, description: 'description', discount: 0, total: 130, fullDescription: "", text: 'text', quantity: 1, weight: 0, tax: 1);
    List<ReceiptItem> line = [];
    line.add(ri);
    ReceiptData rd = ReceiptData(id: 0, referenceNumber: 'referenceNumber', imgTumbUrl: 'imgTumbUrl', thumbnailBytes: 'iVBORw0KGgoAAAANSUhEUgAAAQAAAAEACAIAAADTED8xAAADMElEQVR4nOzVwQnAIBQFQYXff81RUkQCOyDj1YOPnbXWPmeTRef+/3O/OyBjzh3CD95BfqICMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMK0CMO0TAAD//2Anhf4QtqobAAAAAElFTkSuQmCC', deliveryDate: 'deliveryDate', discount: 0, subtotal: 130, total: 130, vendorName: 'vendorName', lineItems: line);
    ReceiptDto? rc = ReceiptDto(id: 0, ourReference: '0', isProcessing: 'false', failureReason: null, createdAt: DateTime.now(), initiator: 'ddd', receiptData: rd);
    setState(() => receiptDto = rc);
    globals.logger.i((receiptDto).toString());

    return;
    receiptService = ReceiptService(context: context);
    friendshipService = FriendshipService(context: context);
    tryGetOne(2).then((value) => {
          if (value == null)
            {
              showCustomDialog(
                  context: context,
                  title: "Something went wrong",
                  content: value!.error,
                  buttonText: "Ok",
                  onPressed: () {
                    Navigator.pop(context);
                  })
            },
          if (value.ok)
            {
              globals.logger.i((value.data as ReceiptDto).toString()),
              setState(() => receiptDto = value.data),
              globals.logger.i(receiptDto?.toString()),
            }
          else
            {
              showCustomDialog(
                  context: context,
                  title: "Something went wrong",
                  content: value.error,
                  buttonText: "Ok",
                  onPressed: () {
                    Navigator.pop(context);
                  })
            }
        });
    print("${widget.id}");

    friendshipService.getFriends().then((value) => {this.friends = value});
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<Widget> loadItems(ReceiptData? receiptData) {
    if (receiptData == null) return [];
    if (receiptData.lineItems == null) return [];

    List<Widget> list = [];
    for (int i = 0; i <= receiptData.lineItems!.length - 1; i++) {
      Widget w = SingleItem(
        name: receiptData.lineItems![i].text ?? "",
        quantity: receiptData.lineItems![i].quantity ?? 0.0,
        total: receiptData.lineItems![i].total ?? 0.0,
      );
      list.add(w);
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Align(
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
                      IconButton(
                        icon: Icon(Icons.cancel_rounded),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      )
                    ],
                  ),
                  (receiptDto?.isProcessing == "FAILED" &&
                          receiptDto?.failureReason != null)
                      ? Container(
                          width: double.infinity,
                          color: Colors.red,
                          padding: EdgeInsets.all(5.0),
                          child: Text(
                            '${receiptDto?.failureReason}',
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        )
                      : const SizedBox(
                          width: 0,
                        ),
                  SizedBox(height: 16),
                  (receiptDto?.createdAt == null)
                      ? Text("")
                      : Text(
                          "Created at: ${DateFormat.yMMMEd().format(receiptDto?.createdAt ?? DateTime.now())} at ${DateFormat.jms().format(receiptDto?.createdAt ?? DateTime.now())}"),
                  Container(
                    height: 200,
                    color: Colors.grey[300],
                    child: Center(
                        child: (receiptDto?.receiptData?.thumbnailBytes != null)
                            ? Image.memory(base64Decode(
                                receiptDto!.receiptData?.thumbnailBytes ?? ""))
                            : Text("Missing Image")),
                  ),
                  SizedBox(height: 20),
                  Text(
                    receiptDto?.receiptData?.vendorName ?? '...',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 10),
                  Text(
                    receiptDto?.receiptData?.total.toString() ?? '...',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Column(
                    children: (receiptDto?.receiptData != null &&
                            receiptDto?.failureReason == null)
                        ? loadItems(receiptDto?.receiptData)
                        : [Text("No items available.")],
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
