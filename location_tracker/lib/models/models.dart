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
  final String desc;
  final int capacity;

  Building({
    this.id = '',
    this.lat = 0.0,
    this.lng = 0.0,
    this.img = 'default.png',
    this.name = '',
    this.desc = '',
    this.capacity = 0,
  });

  factory Building.fromJson(Map<String, dynamic> json) =>
      _$BuildingFromJson(json);
  Map<String, dynamic> toJson() => _$BuildingToJson(this);
}

@JsonSerializable()
class Room {
  final String id;
  final String buildingId;
  final int capacity;
  final String name;
  final String img;
  final String desc;

  Room({
    this.id = '',
    this.buildingId = '',
    this.capacity = 0,
    this.name = '',
    this.img = 'default.png',
    this.desc = '',
  });
  factory Room.fromJson(Map<String, dynamic> json) => _$RoomFromJson(json);
  Map<String, dynamic> toJson() => _$RoomToJson(this);
}

@JsonSerializable()
class Desk {
  final String id;
  final String roomId;
  final bool occupied;
  final bool reserved;

  Desk({
    this.id = '',
    this.roomId = '',
    this.occupied = false,
    this.reserved = false,
  });
  factory Desk.fromJson(Map<String, dynamic> json) => _$DeskFromJson(json);
  Map<String, dynamic> toJson() => _$DeskToJson(this);
}

@JsonSerializable()
class User {
  final String displayName;
  final String email;
  final bool isAdmin;
  final String photoUrl;
  final String uid;

  User(
      {this.photoUrl = '',
      this.uid = '',
      this.email = '',
      this.isAdmin = false,
      this.displayName = ''});
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable()
class UserInBuilding {
  final String buildingId;
  final String userId;

  UserInBuilding({this.buildingId = '', this.userId = ''});
  factory UserInBuilding.fromJson(Map<String, dynamic> json) =>
      _$UserInBuildingFromJson(json);
  Map<String, dynamic> toJson() => _$UserInBuildingToJson(this);

  static fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> doc) {}
}

@JsonSerializable()
class UserInRoom {
  final String roomId;
  final String userId;

  UserInRoom({this.roomId = '', this.userId = ''});
  factory UserInRoom.fromJson(Map<String, dynamic> json) =>
      _$UserInRoomFromJson(json);
  Map<String, dynamic> toJson() => _$UserInRoomToJson(this);
}

@JsonSerializable()
class Log {
  final String buildingId;
  final bool entry;
  final String userId;
  final String? roomId;
  var timestamp;
  Log(
      {this.timestamp = 0,
      this.buildingId = '',
      this.entry = true,
      this.userId = "",
      this.roomId = ""});

  factory Log.fromJson(Map<String, dynamic> json) => _$LogFromJson(json);
  Map<String, dynamic> toJson() => _$LogToJson(this);
}
