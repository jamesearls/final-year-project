import 'package:json_annotation/json_annotation.dart';
part 'models.g.dart';

@JsonSerializable()
class Building {
  final String id;
  final double lat;
  final double lng;

  Building({
    this.id = '',
    this.lat = 0.0,
    this.lng = 0.0,
  });

  factory Building.fromJson(Map<String, dynamic> json) =>
      _$BuildingFromJson(json);
  Map<String, dynamic> toJson() => _$BuildingToJson(this);
}
