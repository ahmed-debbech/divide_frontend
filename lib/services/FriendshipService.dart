import 'dart:convert';

import 'package:divide_frontend/models/FriendshipRegistry.dart';
import 'package:divide_frontend/models/GeneralResponse.dart';
import 'package:divide_frontend/services/common/HandleAuthError.dart';
import 'package:divide_frontend/shared_pref/SharedPrefDb.dart';
import 'package:flutter/material.dart';
import '../globals.dart' as globals;
import 'package:http/http.dart' as http;

class FriendshipService {
  SharedPrefDb shared = SharedPrefDb();
  late BuildContext context;

  FriendshipService({required this.context});

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
      if (response.statusCode == 403 || response.statusCode == 401) {
        handleAuthError(context);
      }
      GeneralResponse gr = GeneralResponse.fromJson(data);
      return gr;
    } catch (e) {
      print(e);
      GeneralResponse gr =
          GeneralResponse(error: "error from client end", ok: false);
      return gr;
    }
  }

  Future<List<FriendshipRegistry>> getFriends() async {
    try {
      final response = await http.get(
          Uri.parse(globals.top_level_api + 'friendship/friends'),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${await shared.getAccessToken()}',
          });
      var data = jsonDecode(response.body);
      if (response.statusCode == 403 || response.statusCode == 401) {
        handleAuthError(context);
      }
      print(data);
      List<FriendshipRegistry> ll = [];
      if (response.statusCode == 200) {
        for (int i = 0; i <= (data as List).length - 1; i++) {
          FriendshipRegistry gr =
              FriendshipRegistry.fromJson((data as List)[i]);
          ll.add(gr);
        }
      }
      return ll;
    } catch (e) {
      print(e);
      return [];
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
      if (response.statusCode == 403 || response.statusCode == 401) {
        handleAuthError(context);
      }
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
      if (response.statusCode == 403 || response.statusCode == 401) {
        handleAuthError(context);
      }
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
      if (response.statusCode == 403 || response.statusCode == 401) {
        handleAuthError(context);
      }
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
