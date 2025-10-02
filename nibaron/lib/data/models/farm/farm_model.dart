import 'package:json_annotation/json_annotation.dart';

part 'farm_model.g.dart';

@JsonSerializable()
class FarmModel {
  final String id;
  final String userId;
  final String name;
  final double latitude;
  final double longitude;
  final String address;
  final double landSize;
  final String landSizeUnit; // acre, bigha, katha
  final String soilType;
  final List<String> cropIds;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isActive;

  FarmModel({
    required this.id,
    required this.userId,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.landSize,
    this.landSizeUnit = 'acre',
    required this.soilType,
    this.cropIds = const [],
    required this.createdAt,
    required this.updatedAt,
    this.isActive = true,
  });

  factory FarmModel.fromJson(Map<String, dynamic> json) =>
      _$FarmModelFromJson(json);

  Map<String, dynamic> toJson() => _$FarmModelToJson(this);

  FarmModel copyWith({
    String? id,
    String? userId,
    String? name,
    double? latitude,
    double? longitude,
    String? address,
    double? landSize,
    String? landSizeUnit,
    String? soilType,
    List<String>? cropIds,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isActive,
  }) {
    return FarmModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      address: address ?? this.address,
      landSize: landSize ?? this.landSize,
      landSizeUnit: landSizeUnit ?? this.landSizeUnit,
      soilType: soilType ?? this.soilType,
      cropIds: cropIds ?? this.cropIds,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isActive: isActive ?? this.isActive,
    );
  }
}
