import 'package:divide_frontend/services/AuthService.dart';
import 'package:divide_frontend/shared_pref/SharedPrefDb.dart';
import 'package:divide_frontend/ui/FadeIn.dart';
import 'package:divide_frontend/ui/pages/MyReceiptsPage.dart';
import 'package:divide_frontend/ui/common/dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class VerificationPage extends StatefulWidget {
  @override
  _VerificationPageState createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  final List<FocusNode> _focusNodes = List.generate(4, (index) => FocusNode());
  final List<TextEditingController> _controllers =
      List.generate(4, (index) => TextEditingController());

  AuthService authService = AuthService();
  SharedPrefDb sharedPrefDb = SharedPrefDb();

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 4; i++) {
      _controllers[i].addListener(() {
        if (_controllers[i].text.length == 1 && i < 3) {
          _focusNodes[i + 1].requestFocus();
        }
        if (_controllers[i].text.isEmpty && i > 0) {
          _focusNodes[i - 1].requestFocus();
        }
      });
    }
  }

  @override
  void dispose() {
    _focusNodes.forEach((node) => node.dispose());
    _controllers.forEach((controller) => controller.dispose());
    super.dispose();
  }

  void _handlePaste(String text) {
    if (text.length == 4) {
      for (int i = 0; i < 4; i++) {
        _controllers[i].text = text[i];
      }
    }
  }

  String _readFully() {
    String otp = "";
    for (int i = 0; i < 4; i++) {
      otp += _controllers[i].text;
    }
    return otp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Enter your authentication code',
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            SizedBox(height: 20),
            FadeIn(
              duration: Duration(milliseconds: 500),
              child: Container(
                width: 250,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(4, (index) {
                    return Container(
                      width: 50,
                      child: TextField(
                        focusNode: _focusNodes[index],
                        controller: _controllers[index],
                        textAlign: TextAlign.center,
                        maxLength: 1,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        decoration: InputDecoration(
                          counterText: '',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onChanged: (text) {
                          if (text.isEmpty) {
                            if (index > 0) {
                              _focusNodes[index - 1].requestFocus();
                            }
                          } else {
                            if (index < 3) {
                              _focusNodes[index + 1].requestFocus();
                            }
                          }
                          setState(() {
                            _controllers[index].text = text;
                          });
                        },
                      ),
                    );
                  }),
                ),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 250,
              child: ElevatedButton(
                onPressed: () async {
                  String otp = _readFully();
                  print(otp);
                  authService
                      .performLoginValidation(
                          await sharedPrefDb.getEmail(), otp)
                      .then((value) async => {
                            if (value.ok)
                              {
                                await sharedPrefDb.storeAccessToken(value.data as String),
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyReceiptsPage()),
                                )
                              }
                            else
                              {
                                showCustomDialog(
                                  context: context,
                                  title: 'Error',
                                  content: '${value.error}',
                                  buttonText: 'OK',
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pop(); // Close the dialog
                                  },
                                )
                              }
                          });
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.blueAccent),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      EdgeInsets.symmetric(horizontal: 30)),
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                child: Text('Login',
                    style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
