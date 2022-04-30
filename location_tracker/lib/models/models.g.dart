// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Building _$BuildingFromJson(Map<String, dynamic> json) => Building(
      id: json['id'] as String? ?? '',
      lat: (json['lat'] as num?)?.toDouble() ?? 0.0,
      lng: (json['lng'] as num?)?.toDouble() ?? 0.0,
      img: json['img'] as String? ?? 'default.png',
      name: json['name'] as String? ?? '',
      desc: json['desc'] as String? ?? '',
      capacity: json['capacity'] as int? ?? 0,
    );

Map<String, dynamic> _$BuildingToJson(Building instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'lat': instance.lat,
      'lng': instance.lng,
      'img': instance.img,
      'desc': instance.desc,
      'capacity': instance.capacity,
    };

Room _$RoomFromJson(Map<String, dynamic> json) => Room(
      id: json['id'] as String? ?? '',
      buildingId: json['buildingId'] as String? ?? '',
      capacity: json['capacity'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      img: json['img'] as String? ?? 'default.png',
      desc: json['desc'] as String? ?? '',
    );

Map<String, dynamic> _$RoomToJson(Room instance) => <String, dynamic>{
      'id': instance.id,
      'buildingId': instance.buildingId,
      'capacity': instance.capacity,
      'name': instance.name,
      'img': instance.img,
      'desc': instance.desc,
    };

User _$UserFromJson(Map<String, dynamic> json) => User(
      photoUrl: json['photoUrl'] as String? ?? '',
      uid: json['uid'] as String? ?? '',
      email: json['email'] as String? ?? '',
      isAdmin: json['isAdmin'] as bool? ?? false,
      displayName: json['displayName'] as String? ?? '',
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'displayName': instance.displayName,
      'email': instance.email,
      'isAdmin': instance.isAdmin,
      'photoUrl': instance.photoUrl,
      'uid': instance.uid,
    };

UserInBuilding _$UserInBuildingFromJson(Map<String, dynamic> json) =>
    UserInBuilding(
      buildingId: json['buildingId'] as String? ?? '',
      userId: json['userId'] as String? ?? '',
    );

Map<String, dynamic> _$UserInBuildingToJson(UserInBuilding instance) =>
    <String, dynamic>{
      'buildingId': instance.buildingId,
      'userId': instance.userId,
    };

UserInRoom _$UserInRoomFromJson(Map<String, dynamic> json) => UserInRoom(
      roomId: json['roomId'] as String? ?? '',
      userId: json['userId'] as String? ?? '',
    );

Map<String, dynamic> _$UserInRoomToJson(UserInRoom instance) =>
    <String, dynamic>{
      'roomId': instance.roomId,
      'userId': instance.userId,
    };

Log _$LogFromJson(Map<String, dynamic> json) => Log(
      timestamp: json['timestamp'] ?? 0,
      buildingId: json['buildingId'] as String? ?? '',
      entry: json['entry'] as bool? ?? true,
      userId: json['userId'] as String? ?? "",
      roomId: json['roomId'] as String? ?? "",
    );

Map<String, dynamic> _$LogToJson(Log instance) => <String, dynamic>{
      'buildingId': instance.buildingId,
      'entry': instance.entry,
      'userId': instance.userId,
      'roomId': instance.roomId,
      'timestamp': instance.timestamp,
    };
