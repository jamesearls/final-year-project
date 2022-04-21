import 'package:flutter/material.dart';
import 'package:location_tracker/services/firestore.dart';

import '../../models/models.dart';

class RoomView extends StatelessWidget {
  final Room room;
  const RoomView({Key? key, required this.room}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: room.img,
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) => RoomScreen(room: room),
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 3,
                child: SizedBox(
                  child: Image.asset(
                    'assets/images/${room.img}',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Text(
                    room.name,
                    style: const TextStyle(
                      height: 1.5,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.fade,
                    softWrap: false,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RoomScreen extends StatelessWidget {
  final Room room;
  const RoomScreen({Key? key, required this.room}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(room.name),
        backgroundColor: Colors.transparent,
      ),
      body: ListView(children: [
        Hero(
          tag: room.img,
          child: Image.asset('assets/images/${room.img}',
              width: MediaQuery.of(context).size.width),
        ),
        Text(
          room.name,
          style: const TextStyle(
              height: 2, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        FutureBuilder(
          future:
              FirestoreService().getUsersInRooms(room.id), // rooms need id's
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return Text(
              '${snapshot.data}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            );
          },
        ),
      ]),
    );
  }
}
