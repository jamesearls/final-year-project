import 'package:flutter/material.dart';
import 'package:location_tracker/screens/rooms/desk_list.dart';
import 'package:location_tracker/screens/rooms/desk_sheet.dart';
import 'package:location_tracker/services/firestore.dart';
import 'package:location_tracker/shared/loading.dart';
import 'package:location_tracker/shared/occupantCount.dart';
import 'package:location_tracker/shared/progress_bar.dart';

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
              Flexible(child: RoomCapacity(room: room)),
            ],
          ),
        ),
      ),
    );
  }
}

class RoomScreen extends StatefulWidget {
  final Room room;
  const RoomScreen({Key? key, required this.room}) : super(key: key);

  @override
  State<RoomScreen> createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.room.name),
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: ListView(children: [
              Hero(
                tag: widget.room.img,
                child: Image.asset('assets/images/${widget.room.img}',
                    width: MediaQuery.of(context).size.width),
              ),
              Text(
                widget.room.name,
                style: const TextStyle(
                    height: 2, fontSize: 20, fontWeight: FontWeight.bold),
              ),
              RoomCount(roomId: widget.room.id)
            ]),
          ),
          Flexible(
            child: DeskSheet(room: widget.room),
          ),
        ],
      ),
    );
  }
}
