import 'dart:io';

import 'package:divide_frontend/models/UserWithFriendship.dart';
import 'package:divide_frontend/services/FriendshipService.dart';
import 'package:divide_frontend/services/UsersService.dart';
import 'package:divide_frontend/ui/common/dialog.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class FindFriendsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FindFriendsPageState();
}

class _FindFriendsPageState extends State<FindFriendsPage> {
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  bool onScanning = false;
  String? scannedQrData;
  UserWithFriendship? userFriends;

  late UsersService us;
  bool successful = false;
  late FriendshipService fs;

  @override
  void dispose() {
    //controller!.dispose();
    super.dispose();
  }

  @override
  void initState() {
    us = UsersService(context: context);
    fs = FriendshipService(context: context);
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter text',
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                onScanning = !onScanning;
              });
            },
            child: Text('SCAN'),
          ),
        ],
      ),
      Expanded(
          flex: 4,
          child: (onScanning)
              ? _buildQrView(context)
              : Container(
                  child: (successful)
                      ? Center(
                          child: Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Container(
                                      width: 100,
                                      height: 100,
                                      child: Center(
                                          child: Text(
                                              (userFriends!.fullName != '')
                                                  ? userFriends!.fullName[0]
                                                  : '',
                                              style: TextStyle(fontSize: 50))),
                                      decoration: const ShapeDecoration(
                                          color: Colors.white,
                                          shape: CircleBorder(
                                              side: BorderSide(
                                                  width: 5,
                                                  color: Colors.blue)))),
                                  const SizedBox(height: 5),
                                  Text(
                                    userFriends!.fullName,
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    'Uid: ${userFriends!.uid}',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  _decideWhichButton()
                                ],
                              ),
                            ),
                          ),
                        )
                      : Container())),
    ]);
  }

  void processQr() {
    us.searchForUser(scannedQrData!).then((value) => {
          setState(() => {
                if (value.ok)
                  {
                    userFriends = value.data as UserWithFriendship?,
                    successful = true
                  }
                else
                  {
                    showCustomDialog(
                      context: context,
                      title: 'Error',
                      content: '${value.error}',
                      buttonText: 'OK',
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    successful = false
                  }
              })
        });
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.blue,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      print(scanData.code);
      setState(() {
        scannedQrData = scanData.code;
      });
      controller.pauseCamera();
      Future.delayed(const Duration(milliseconds: 2000), () {
        setState(() {
          onScanning = false;
        });
        processQr();
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    print('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not grant camera permission!')),
      );
    }
  }

  Widget _decideWhichButton() {
    if (userFriends!.friendshipStatus == "NOT_FRIENDS") {
      return Row(children: [
        ElevatedButton(
            onPressed: () {
              fs.request(userFriends!.uid).then((value) => {
                    setState(() {
                      this.successful = false;
                    })
                  });
            },
            child: const Text("Request friendship"),
            style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.blue)))))
      ]);
    }
    if (userFriends!.friendshipStatus == "FRIENDS") {
      return Row(children: [
        ElevatedButton(
            onPressed: () {
              fs.unfriend(userFriends!.friendshipId).then((value) => {
                    setState(() {
                      this.successful = false;
                    })
                  });
            },
            child: const Text("Unfriend"),
            style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.blue)))))
      ]);
    }
    if (userFriends!.friendshipStatus == "ACCEPTABLE") {
      return Row(children: [
        Expanded(
            child: ElevatedButton(
                onPressed: () {
                  fs.accept(userFriends!.friendshipId).then((value) => {
                        setState(() {
                          this.successful = false;
                        })
                      });
                },
                child: const Text("Accept"),
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.blue)))))),
        Expanded(
            child: ElevatedButton(
                onPressed: () {
                  fs.cancel(userFriends!.friendshipId).then((value) => {
                        setState(() {
                          this.successful = false;
                        })
                      });
                },
                child: const Text("Refuse"),
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.red))))))
      ]);
    }
    if (userFriends!.friendshipStatus == "CANCELABLE") {
      return Row(children: [
        ElevatedButton(
            onPressed: () {
              fs.cancel(userFriends!.friendshipId).then((value) => {
                    setState(() {
                      this.successful = false;
                    })
                  });
            },
            child: const Text("Cancel"),
            style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.blue)))))
      ]);
    }
    return Container();
  }
}
