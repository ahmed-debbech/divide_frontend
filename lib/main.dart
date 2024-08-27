import 'package:divide_frontend/shared_pref/SharedPrefDb.dart';
import 'package:divide_frontend/ui/Login.dart';
import 'package:divide_frontend/ui/pages/MyReceiptsPage.dart';
import 'package:divide_frontend/ui/Shell.dart';
import 'package:divide_frontend/ui/pages/NewReceiptPage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  SharedPrefDb sharedPrefDb = SharedPrefDb();
  bool? isLoggedIn;

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    bool loggedIn = (await sharedPrefDb.getAccessToken()) != "";
    loggedIn = (await sharedPrefDb.getEmail()) != "";

    setState(() {
      isLoggedIn = loggedIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoggedIn == null) {
      // While waiting for the login status, you can show a loading indicator
      return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    } else {
      isLoggedIn = false;
      return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: isLoggedIn! ? Shell() : NewReceiptPage(id: "d"),//LoginPage(),
      );
    }
  }
}
