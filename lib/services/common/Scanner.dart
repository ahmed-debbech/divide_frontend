import 'dart:async';

import 'package:divide_frontend/models/ResponseHolder.dart';
import 'package:divide_frontend/services/ReceiptService.dart';

class Scanner {
  final String base64Img;
  String? receiptReturnedId;
  bool hasFinishedProcessing = false;
  ReceiptService service;
  bool detached = false;
  Timer? currentTimerChecker;

  Scanner({required this.base64Img, required this.service}) {
    hasFinishedProcessing = false;
    receiptReturnedId = null;
    detached = false;
  }

  Future<void> sendDataToScan() async {
    ResponseHolder resp = await service.sendDataToScan(this.base64Img);
    if(detached) return;

    if (resp.ok) {
      this.receiptReturnedId = resp.data["processingAuthCode"];
    } else {
      throw Exception();
    }
  }

  Future<void> keepCheckProgress() async {
    currentTimerChecker = Timer.periodic(Duration(seconds: 1), (Timer t) {
      service.checkProgress(receiptReturnedId!).then((v) => {            
            if (v.ok)
              {
                print(v.data["ready"]),
                if (v.data["ready"] as bool == true)
                  {
                    this.hasFinishedProcessing = true,
                    t.cancel(),
                  }
              }
            else
              {
                this.hasFinishedProcessing = false,
                t.cancel(),
                throw Exception()
              }
          });
    });
  }

  void detach() {
    this.detached = true;
    
    currentTimerChecker?.cancel();
  }
}
