import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

class ScanReceiptPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ScanReceiptPageState();
}

class _ScanReceiptPageState extends State<ScanReceiptPage> {
  File? _image;

  final ImagePicker _picker = ImagePicker();

  void _transferPic() {
    List<int> imageBytes = _image!.readAsBytesSync();
    String base64Image = base64Encode(imageBytes);
    print(base64Image);
  }

  Future<void> _takePhoto() async {
    print("picking...");
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      setState(() {
        _image = File(photo.path);
      });
      _transferPic();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
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
              _image == null ? Text('No image selected.') : Image.file(_image!),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _takePhoto,
                child: Text('Take Photo'),
              ),
            ])));
  }
}
