import 'dart:convert';

import 'package:divide_frontend/models/ResponseHolder.dart';
import 'package:divide_frontend/models/UserWithFriendship.dart';
import 'package:divide_frontend/services/common/HandleAuthError.dart';
import 'package:divide_frontend/shared_pref/SharedPrefDb.dart';
import 'package:flutter/material.dart';
import '../globals.dart' as globals;
import 'package:http/http.dart' as http;

class ReceiptService {
  SharedPrefDb shared = SharedPrefDb();

  late BuildContext context;

  ReceiptService({required this.context});

  Future<ResponseHolder> sendDataToScan(String dataa) async {
    try {
      final response =
          await http.post(Uri.parse('${globals.top_level_api}receipt/scan'),
              headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json',
                'Authorization': 'Bearer ${await shared.getAccessToken()}',
              },
              body: jsonEncode(<String, dynamic>{'uploadedPic': dataa}));
      if (response.statusCode == 403 || response.statusCode == 401) {
        handleAuthError(context);
      }
      var data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        ResponseHolder gr = ResponseHolder(error: "", ok: true, data: data);
        return gr;
      } else {
        ResponseHolder gr =
            ResponseHolder(error: data["error"], ok: false, data: "");
        return gr;
      }
    } catch (e) {
      print(e);
      ResponseHolder gr =
          ResponseHolder(error: "error from client end", ok: false, data: "");
      return gr;
    }
  }
}
