import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:location_tracker/models/models.dart';

class LogList extends StatelessWidget {
  final Log log;
  const LogList({Key? key, required this.log}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    String activity = '';
    Timestamp timestamp = log.timestamp;
    DateTime dateTime = timestamp.toDate();
    // var d24 = DateFormat('yyyy-MM-dd HH:mm:ss').format(timestamp);
    if (log.entry == true) {
      activity = 'entered';
    } else {
      activity = 'exited';
    }
    if (log.roomId == "" || log.roomId == null) {
      return ListTile(
        title: Text('${log.userId} $activity building: ${log.buildingId}'),
        subtitle: Text(dateTime.toString()),
      );
    } else {
      return ListTile(
        title: Text('${log.userId} $activity room: ${log.roomId}'),
        subtitle: Text(dateTime.toString()),
      );
    }
  }
}
