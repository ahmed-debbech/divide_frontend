import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRCodeWidget extends StatelessWidget {
  final String data; // The text you want to encode in the QR code
  final double size; // Optional: Size of the QR code widget (default: 200)

  const QRCodeWidget({Key? key, required this.data, this.size = 200.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: QrImageView(
        data: '${this.data}',
        version: QrVersions.auto,
        size: 200.0,
      ),
    );
  }
}
