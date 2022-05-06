import 'package:flutter/material.dart';
import 'package:location_tracker/models/models.dart';
import 'package:location_tracker/screens/rooms/desk_list.dart';
import 'package:location_tracker/shared/loading.dart';
import 'package:provider/provider.dart';

class DeskSheet extends StatefulWidget {
  final Room room;
  const DeskSheet({Key? key, required this.room}) : super(key: key);

  @override
  State<DeskSheet> createState() => _DeskSheetState();
}

class _DeskSheetState extends State<DeskSheet> {
  @override
  Widget build(BuildContext context) {
    List<Desk>? alldesks = Provider.of<List<Desk>?>(context);
    if (alldesks == null) {
      return const LoadingScreen();
    } else {
      List<Desk> desklist =
          alldesks.where((Desk desk) => desk.roomId == widget.room.id).toList();
      List<Desk> desks = List.from(desklist.reversed);
      return DraggableScrollableSheet(
        builder: (context, scrollController) {
          if (desks.isNotEmpty) {
            return Container(
              decoration: const BoxDecoration(
                color: Colors.deepPurple,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.0),
                  topRight: Radius.circular(40.0),
                ),
              ),
              child: ListView(controller: scrollController, children: [
                ListTile(
                  title: Center(child: Text('Desks in ${widget.room.name}:')),
                ),
                for (Desk desk in desks)
                  DeskList(
                    onReserveSelected: () => setState(() {}),
                    desk: desk,
                  ),
              ]),
            );
          } else {
            return Center(
              child: Text('No desks in ${widget.room.name}'),
            );
          }
        },
      );
    }
  }
}
