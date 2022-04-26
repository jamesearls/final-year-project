import 'package:flutter/material.dart';
import 'package:location_tracker/models/models.dart';
import 'package:location_tracker/shared/loading.dart';
import 'package:provider/provider.dart';

class AnimatedProgressBar extends StatelessWidget {
  final double value;
  final double height;
  const AnimatedProgressBar({Key? key, required this.value, this.height = 12})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints box) {
        return Container(
          padding: const EdgeInsets.all(10),
          width: box.maxWidth,
          child: Stack(
            children: [
              Container(
                height: height,
                decoration: BoxDecoration(
                  color: Theme.of(context).backgroundColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(height),
                  ),
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 800),
                curve: Curves.easeOutCubic,
                height: height,
                width: box.maxWidth * _floor(value),
                decoration: BoxDecoration(
                  color: _colourGen(value),
                  borderRadius: BorderRadius.all(
                    Radius.circular(height),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

_floor(double value, [min = 0.0]) {
  return value.sign <= min ? min : value;
}

_colourGen(double value) {
  int rgb = (value * 255).toInt();
  return Colors.deepOrange.withRed(rgb).withGreen(255 - rgb);
}

class BuildingCapacity extends StatelessWidget {
  const BuildingCapacity({Key? key, required this.building}) : super(key: key);

  final Building building;

  @override
  Widget build(BuildContext context) {
    List<UserInBuilding>? uib = Provider.of<List<UserInBuilding>?>(context);
    int currentUsers = 0;
    if (uib == null) {
      return const LoadingScreen();
    } else {
      for (UserInBuilding u in uib) {
        if (u.buildingId == building.id) {
          currentUsers++;
        }
      }
    }
    return Row(
      children: [
        _buildingCapacity(context, building, currentUsers),
        Expanded(
          child: AnimatedProgressBar(
              value: _calculateCapacity(context, building, currentUsers),
              height: 8),
        ),
      ],
    );
  }
}

Widget _buildingCapacity(
    BuildContext context, Building building, int currentUsers) {
  return Padding(
    padding: const EdgeInsets.only(left: 8),
    child: Text(
      '$currentUsers / ${building.capacity}',
      style: const TextStyle(
        fontSize: 10,
        color: Colors.grey,
      ),
    ),
  );
}

double _calculateCapacity(
    BuildContext context, Building building, currentUsers) {
  try {
    return currentUsers / building.capacity;
  } catch (e) {
    return 0;
  }
}

class RoomCapacity extends StatelessWidget {
  const RoomCapacity({Key? key, required this.room}) : super(key: key);
  final Room room;

  @override
  Widget build(BuildContext context) {
    List<UserInRoom>? uir = Provider.of<List<UserInRoom>?>(context);
    int currentUsers = 0;
    if (uir == null) {
      return const LoadingScreen();
    } else {
      for (UserInRoom u in uir) {
        if (u.roomId == room.id) {
          currentUsers++;
        }
      }
    }
    return Row(
      children: [
        _roomCapacity(context, room, currentUsers),
        Expanded(
          child: AnimatedProgressBar(
              value: _calculateRoomCapacity(context, room, currentUsers),
              height: 8),
        ),
      ],
    );
  }
}

Widget _roomCapacity(BuildContext context, Room room, int currentUsers) {
  return Padding(
    padding: const EdgeInsets.only(left: 8),
    child: Text(
      '$currentUsers / ${room.capacity}',
      style: const TextStyle(
        fontSize: 10,
        color: Colors.grey,
      ),
    ),
  );
}

double _calculateRoomCapacity(BuildContext context, Room room, currentUsers) {
  try {
    return currentUsers / room.capacity;
  } catch (e) {
    return 0;
  }
}
