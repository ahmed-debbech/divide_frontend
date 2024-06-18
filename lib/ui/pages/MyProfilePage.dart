import 'package:divide_frontend/models/MyProfileData.dart';
import 'package:divide_frontend/services/UsersService.dart';
import 'package:divide_frontend/ui/common/QrCodeWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfilePage> {

  UsersService us = UsersService();
  MyProfileData mpd = MyProfileData(fullName: "", email: "", uid: "");

  @override
  void initState(){
    us.getProfileData().then((value) => {
      setState(() => mpd = value
      )
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Container(
            width: 150,
            height: 300,
            child: Center(child: Text((mpd.fullName != '')?mpd.fullName[0] : '', style: TextStyle(fontSize: 50))),
            decoration: const ShapeDecoration(
                color: Colors.white,
                shape: CircleBorder(
                    side: BorderSide(width: 10, color: Colors.blue)))),
        const SizedBox(height: 5),
        Text(
          mpd.fullName,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          'Uid: ${mpd.uid}',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w300,
          ),
        ),
        if(mpd.uid != "")
        QRCodeWidget(data: "${mpd.uid}"),
        if(mpd.uid != "")
        Text("Share it with your friends!")
       
      ],
    ));
  }
}
