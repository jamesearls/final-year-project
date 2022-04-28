import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:location_tracker/services/nfcService.dart';

class NfcButton extends StatelessWidget {
  const NfcButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NfcService nfcService = NfcService();
    return Container(
      padding: const EdgeInsets.all(8),
      child: FloatingActionButton(
        onPressed: () {
          showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text('Ready to Scan!'),
              content: const Text(
                  'Please move into a room in your and scan the NFC tag.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Cancel'),
                  child: const Text('Dismiss'),
                ),
              ],
            ),
          );
          nfcService.getPayload();
        },
        backgroundColor: Colors.deepPurple,
        child: const Icon(
          FontAwesomeIcons.nfcSymbol,
          color: Colors.white,
        ),
      ),
    );
  }
}
