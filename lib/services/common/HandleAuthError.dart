import 'package:divide_frontend/ui/Login.dart';
import 'package:flutter/material.dart';

void handleAuthError(BuildContext context) {
  // Display an error message or redirect to login based on your requirements
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Can not authorize you'),
      content:
          Text('It seems you are not auhtorized anymore. Please login again!'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
                ModalRoute.withName("/Home"));
          },
          child: Text('Login'),
        ),
      ],
    ),
  );
}
