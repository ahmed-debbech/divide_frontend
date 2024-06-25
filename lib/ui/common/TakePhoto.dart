import 'dart:convert';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

class TakePhoto{

  XFile? _image;

  final ImagePicker _picker = ImagePicker();
  
  Future<String> _takePhoto() async {
    print("picking...");
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
        _image = photo;
        return convertPic();      
    }
    return "";
  }

  String convertPic() {
    print("fileee ${_image!.path}");
    File o = File(_image!.path);
    List<int> bytes = o.readAsBytesSync();
    String base64 = base64Encode(bytes);
    //receiptService.sendDataToScan(base64);
    return base64;
  }

  Future<String> capture() async{
    String base = await _takePhoto();
    return base;
  }
}