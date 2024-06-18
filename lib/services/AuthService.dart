import 'dart:convert';

import 'package:divide_frontend/models/GeneralResponse.dart';
import 'package:divide_frontend/models/ResponseHolder.dart';
import 'package:http/http.dart' as http;
import '../globals.dart' as globals;

class AuthService {
  Future<GeneralResponse> performLogin(String email) async {
    try {
      print(email);
      final response =
          await http.post(Uri.parse(globals.top_level_api + 'auth/login'),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: jsonEncode(<String, dynamic>{
                'email': email,
                'uid': ""
                // Add any other data you want to send in the body
              }));
      var data = jsonDecode(response.body);
      GeneralResponse gr = GeneralResponse.fromJson(data);
      return gr;
    } catch (e) {
      print(e);
      GeneralResponse gr =
          GeneralResponse(error: "error from client end", ok: false);
      return gr;
    }
  }

  Future<ResponseHolder> performLoginValidation(String email, String otp) async {
    try {
      print(email);
      final response =
          await http.post(Uri.parse(globals.top_level_api + 'auth/login/valid'),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: jsonEncode(<String, dynamic>{
                'email': email,
                'uid': "",
                'code': otp
                // Add any other data you want to send in the body
              }));
      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return ResponseHolder(error: "", ok: true, data: data["token"]);
      }
      return ResponseHolder(error: data["error"], ok: false, data: "");
    } catch (e) {
      print(e);
      return ResponseHolder(error: "error from client end", ok: false, data: "");
    }
  }
}
