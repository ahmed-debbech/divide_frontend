import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:divide_frontend/services/ReceiptService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';

class ScanReceiptPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ScanReceiptPageState();
}

class _ScanReceiptPageState extends State<ScanReceiptPage> {
  XFile? _image;

  final ImagePicker _picker = ImagePicker();

  late ReceiptService receiptService;

  @override
  void initState() {
    receiptService = ReceiptService(context: context);
  }

  void _transferPic() {
    print("fileee ${_image!.path}");
    File o = File(_image!.path);
    List<int> bytes = o.readAsBytesSync();
    String base64 = base64Encode(bytes);
    receiptService.sendDataToScan(base64)
  }

  Future<void> _takePhoto() async {
    print("picking...");
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      setState(() {
        _image = photo;
      });
      _transferPic();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(children: [
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
                  _image == null
                      ? Text('No picture was selected')
                      : Text('Rceipt is getting uploaded! please wait'),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _takePhoto,
                    child: Text('Take Photo'),
                  ),
                ]))));
  }
}
