import 'dart:convert';

import 'package:divide_frontend/models/MyProfileData.dart';
import 'package:divide_frontend/shared_pref/SharedPrefDb.dart';
import '../globals.dart' as globals;
import 'package:http/http.dart' as http;

class UsersService {

  SharedPrefDb shared = SharedPrefDb();

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
      if (response.statusCode == 200) {
        MyProfileData m = MyProfileData.fromJson(data);
        return m;
      } else {
        throw Exception();
      }
    } catch (e) {
      print(e);
      MyProfileData m =
          MyProfileData(fullName: "", email: "", uid: "");
      return m;
    }
  }
}
