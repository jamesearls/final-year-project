import 'package:flutter/material.dart';

class ReservationAlert extends StatelessWidget {
  final String deskId;
  const ReservationAlert({Key? key, required this.deskId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: const Text('Reservation successful'),
        content:
            Text('You have successfully reserved desk: $deskId for 1 hour'),
        actions: [
          TextButton(
            child: const Text('Dismiss'),
            onPressed: () {},
          ),
        ]);
  }
}
