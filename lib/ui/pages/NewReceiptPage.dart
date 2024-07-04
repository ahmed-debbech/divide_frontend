import 'package:divide_frontend/models/Receipt.dart';
import 'package:divide_frontend/services/ReceiptService.dart';
import 'package:divide_frontend/ui/common/SingleItem.dart';
import 'package:divide_frontend/ui/common/dialog.dart';
import 'package:flutter/material.dart';
import 'package:divide_frontend/globals.dart' as globals;

class NewReceiptPage extends StatefulWidget {
  late String id;

  NewReceiptPage({super.key, required this.id});

  @override
  State<NewReceiptPage> createState() => _NewReceiptPageState();
}

class _NewReceiptPageState extends State<NewReceiptPage> {
  late ReceiptService receiptService;
  ReceiptDto? receiptDto = null;

  @override
  void initState() {
    receiptService = ReceiptService(context: context);
    receiptService.getOne(widget.id).then((value) => {
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
                  Text("Created at: ${receiptDto?.createdAt ?? "..."}"),
                  Container(
                    height: 200,
                    color: Colors.grey[300],
                    child: Center(child: Text('Picture')),
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
                  SingleChildScrollView(
                    child: Column(
                      children: (receiptDto?.receiptData != null &&
                              receiptDto?.failureReason == null)
                          ? loadItems(receiptDto?.receiptData)
                          : [Text("No items available.")],
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
