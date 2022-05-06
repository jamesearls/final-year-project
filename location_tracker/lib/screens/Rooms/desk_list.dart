import 'package:flutter/material.dart';
import 'package:location_tracker/models/models.dart';

class DeskList extends StatelessWidget {
  final Desk desk;
  const DeskList({Key? key, required this.desk}) : super(key: key);

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
                  child: const Text('reserve'),
                  onPressed: () {
                    // add reserving functionality
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Colors.deepPurpleAccent),
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
