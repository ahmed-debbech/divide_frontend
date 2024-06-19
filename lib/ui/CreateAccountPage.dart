import 'package:divide_frontend/services/AuthService.dart';
import 'package:divide_frontend/shared_pref/SharedPrefDb.dart';
import 'package:divide_frontend/ui/FadeIn.dart';
import 'package:divide_frontend/ui/Verification.dart';
import 'package:divide_frontend/ui/common/dialog.dart';
import 'package:flutter/material.dart';

class CreateAccountPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();

  late AuthService authService;
  SharedPrefDb spd = SharedPrefDb();

  @override
  void initState() {
    authService = AuthService(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        FadeIn(
          duration: Duration(milliseconds: 500),
          child: Container(
            width: 250,
            padding: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Colors.blueAccent, Colors.lightBlue],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
              controller: _emailController, // Controller added here
              decoration: InputDecoration(
                hintText: 'Enter your email',
                hintStyle: TextStyle(color: Colors.white70),
                border: InputBorder.none,
              ),
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        SizedBox(height: 20),
        FadeIn(
          duration: Duration(milliseconds: 500),
          child: Container(
            width: 250,
            padding: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Colors.blueAccent, Colors.lightBlue],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
              controller: _fullNameController, // Controller added here
              decoration: InputDecoration(
                hintText: 'Full name',
                hintStyle: TextStyle(color: Colors.white70),
                border: InputBorder.none,
              ),
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        SizedBox(
          width: 250,
          child: ElevatedButton(
            onPressed: () {
              authService
                  .performSignup(
                      _emailController.text, _fullNameController.text)
                  .then((value) => {
                        if (value.ok == true)
                          {
                            spd.saveEmail(_emailController.text),
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      VerificationPage(mode: "signup")),
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
                                Navigator.of(context).pop(); // Close the dialog
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
            child: Text('Submit',
                style: TextStyle(fontSize: 16, color: Colors.white)),
          ),
        ),
      ],
    )));
  }
}
