import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
part 'models.g.dart';

@JsonSerializable()
class Building {
  late final String id;
  final String name;
  final double lat;
  final double lng;
  final String img;
// add description here
  Building({
    this.id = '',
    this.lat = 0.0,
    this.lng = 0.0,
    this.img = 'default.png',
    this.name = '',
  });

  factory Building.fromJson(Map<String, dynamic> json) =>
      _$BuildingFromJson(json);
  Map<String, dynamic> toJson() => _$BuildingToJson(this);
}

@JsonSerializable()
class Room {
  final String id;
  final String buildingId;
  final int maxUsers;
  final String name;
  final String img;

  Room({
    this.id = '',
    this.buildingId = '',
    this.maxUsers = 0,
    this.name = '',
    this.img = 'default.png',
  });
  factory Room.fromJson(Map<String, dynamic> json) => _$RoomFromJson(json);
  Map<String, dynamic> toJson() => _$RoomToJson(this);
}

@JsonSerializable()
class User {
  final String email;
  final bool isAdmin;
  final String name;

  User({this.email = '', this.isAdmin = false, this.name = ''});
}

@JsonSerializable()
class UsersInBuildings {
  final String buildingId;
  final String userId;

  UsersInBuildings({this.buildingId = '', this.userId = ''});
  factory UsersInBuildings.fromJson(Map<String, dynamic> json) =>
      _$UsersInBuildingsFromJson(json);
  Map<String, dynamic> toJson() => _$UsersInBuildingsToJson(this);

  static fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> doc) {}
}

@JsonSerializable()
class UsersInRooms {
  final String roomId;
  final String userId;

  UsersInRooms({this.roomId = '', this.userId = ''});
}
