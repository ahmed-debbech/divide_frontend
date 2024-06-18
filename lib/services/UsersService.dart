import 'dart:convert';

import 'package:divide_frontend/models/GeneralResponse.dart';
import 'package:divide_frontend/models/MyProfileData.dart';
import 'package:divide_frontend/models/ResponseHolder.dart';
import 'package:divide_frontend/models/UserWithFriendship.dart';
import 'package:divide_frontend/shared_pref/SharedPrefDb.dart';
import 'package:divide_frontend/ui/Login.dart';
import 'package:divide_frontend/services/common/HandleAuthError.dart';
import 'package:flutter/material.dart';
import '../globals.dart' as globals;
import 'package:http/http.dart' as http;

class UsersService {
  SharedPrefDb shared = SharedPrefDb();

  late BuildContext context;

  UsersService({required this.context});

  Future<MyProfileData> getProfileData() async {
    try {
      final response = await http.get(
          Uri.parse('${globals.top_level_api}users/get_profile'),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${await shared.getAccessToken()}',
          });
      var data = jsonDecode(response.body);
      print(data);

      if (response.statusCode == 403 || response.statusCode == 401) {
        handleAuthError(context);
      }

      if (response.statusCode == 200) {
        MyProfileData m = MyProfileData.fromJson(data);
        return m;
      } else {
        throw Exception();
      }
    } catch (e) {
      print(e);
      MyProfileData m = MyProfileData(fullName: "", email: "", uid: "");
      return m;
    }
  }

  Future<ResponseHolder> searchForUser(String uid) async {
    try {
      final response = await http.get(
          Uri.parse(
              '${globals.top_level_api}users/search_with_friendship/${uid}'),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${await shared.getAccessToken()}',
          });
      if (response.statusCode == 403 || response.statusCode == 401) {
        handleAuthError(context);
      }
      var data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        UserWithFriendship m = UserWithFriendship.fromJson(data);
        ResponseHolder gr = ResponseHolder(error: "", ok: true, data: m);
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
