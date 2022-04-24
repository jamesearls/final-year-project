import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';

class NfcService {
  NfcService();

  ValueNotifier<dynamic> result = ValueNotifier(null);

  void tagReader() {
    NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
      result.value = tag.data;
      print(result.value);
      NfcManager.instance.stopSession();
    });
  }

  void getPayload() {
    NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
      Map ndef = tag.data["ndef"] as Map;
      Map cachedMessage = ndef["cachedMessage"] as Map;
      List records = cachedMessage["records"] as List;
      Map newRecords = records[0];
      List payload = newRecords["payload"] as List;
      List result = List<int>.filled(payload.length, 0);
      for (int i = 0; i < payload.length; i++) {
        result[i] = payload[i];
      }

      List chars = <String>[];
      for (int i = 0; i < result.length; i++) {
        chars.add(String.fromCharCode(result[i]));
      }
      chars.removeRange(0, 3);
      String finalResult = chars.join();

      if (kDebugMode) {
        print(finalResult);
      }

      NfcManager.instance.stopSession();
    });
  }
}
