import 'dart:convert';

import 'package:divide_frontend/models/GeneralResponse.dart';
import 'package:divide_frontend/shared_pref/SharedPrefDb.dart';
import '../globals.dart' as globals;
import 'package:http/http.dart' as http;

class FriendshipService {
  SharedPrefDb shared = SharedPrefDb();

  Future<GeneralResponse> request(String uid) async {
    try {
      final response = await http.put(
          Uri.parse(globals.top_level_api + 'friendship/${uid}/request'),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${await shared.getAccessToken()}',
          });
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

  Future<GeneralResponse> cancel(int friendShipId) async {
    try {
      final response = await http.put(
          Uri.parse(
              globals.top_level_api + 'friendship/${friendShipId}/cancel'),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${await shared.getAccessToken()}',
          });
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

  Future<GeneralResponse> unfriend(int friendShipId) async {
    try {
      final response = await http.put(
          Uri.parse(
              globals.top_level_api + 'friendship/${friendShipId}/unfriend'),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${await shared.getAccessToken()}',
          });
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

  Future<GeneralResponse> accept(int friendShipId) async {
    try {
      final response = await http.put(
          Uri.parse(
              globals.top_level_api + 'friendship/${friendShipId}/accept'),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${await shared.getAccessToken()}',
          });
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
}
