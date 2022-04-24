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
}
