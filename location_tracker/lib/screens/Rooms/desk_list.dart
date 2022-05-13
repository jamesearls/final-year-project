import 'package:flutter/material.dart';
import 'package:location_tracker/models/models.dart';
import 'package:location_tracker/screens/rooms/reservation_alert.dart';
import 'package:location_tracker/services/firestore.dart';

class DeskList extends StatelessWidget {
  final Desk desk;
  final VoidCallback onReserveSelected;

  const DeskList(
      {Key? key, required this.desk, required this.onReserveSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Desk currentDesk = desk;
    return Column(
      children: [
        Container(
          height: 50,
          decoration: BoxDecoration(
            color: Colors.deepPurple,
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(40.0),
                bottomRight: Radius.circular(40.0),
                topLeft: Radius.circular(40.0),
                bottomLeft: Radius.circular(40.0)),
            border: Border.all(
              color: Colors.grey,
            ),
          ),
          padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(currentDesk.id),
            Builder(builder: (context) {
              if (currentDesk.occupied == false &&
                  currentDesk.reserved == false) {
                return ElevatedButton(
                  onPressed: () {
                    // add reserving functionality
                    FirestoreService().reserveDesk(desk);
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => ReservationAlert(
                        deskId: desk.id,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Colors.deepPurpleAccent),
                  child: const Text('reserve'),
                );
              } else if (currentDesk.occupied == true) {
                return const Text('Occupied');
              } else {
                return const Text('Reserved');
              }
            }),
          ]),
        ),
        const SizedBox(height: 10),
      ],
    );
    // return ListTile(
    //   title: Text(currentDesk.id),
    // );
  }
}
