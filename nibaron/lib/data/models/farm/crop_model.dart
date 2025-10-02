import 'package:json_annotation/json_annotation.dart';

part 'crop_model.g.dart';

@JsonSerializable()
class CropModel {
  final String id;
  final String farmId;
  final String name;
  final String type; // rice, wheat, corn, etc.
  final String variety;
  final DateTime plantingDate;
  final DateTime? expectedHarvestDate;
  final String growthStage; // seedling, vegetative, flowering, fruiting, maturity
  final double plantedArea;
  final String plantedAreaUnit;
  final String status; // active, harvested, failed
  final Map<String, dynamic>? additionalInfo;
  final DateTime createdAt;
  final DateTime updatedAt;

  CropModel({
    required this.id,
    required this.farmId,
    required this.name,
    required this.type,
    required this.variety,
    required this.plantingDate,
    this.expectedHarvestDate,
    this.growthStage = 'seedling',
    required this.plantedArea,
    this.plantedAreaUnit = 'acre',
    this.status = 'active',
    this.additionalInfo,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CropModel.fromJson(Map<String, dynamic> json) =>
      _$CropModelFromJson(json);

  Map<String, dynamic> toJson() => _$CropModelToJson(this);

  CropModel copyWith({
    String? id,
    String? farmId,
    String? name,
    String? type,
    String? variety,
    DateTime? plantingDate,
    DateTime? expectedHarvestDate,
    String? growthStage,
    double? plantedArea,
    String? plantedAreaUnit,
    String? status,
    Map<String, dynamic>? additionalInfo,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return CropModel(
      id: id ?? this.id,
      farmId: farmId ?? this.farmId,
      name: name ?? this.name,
      type: type ?? this.type,
      variety: variety ?? this.variety,
      plantingDate: plantingDate ?? this.plantingDate,
      expectedHarvestDate: expectedHarvestDate ?? this.expectedHarvestDate,
      growthStage: growthStage ?? this.growthStage,
      plantedArea: plantedArea ?? this.plantedArea,
      plantedAreaUnit: plantedAreaUnit ?? this.plantedAreaUnit,
      status: status ?? this.status,
      additionalInfo: additionalInfo ?? this.additionalInfo,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  int get daysFromPlanting {
    return DateTime.now().difference(plantingDate).inDays;
  }

  int? get daysToHarvest {
    if (expectedHarvestDate == null) return null;
    final days = expectedHarvestDate!.difference(DateTime.now()).inDays;
    return days > 0 ? days : 0;
  }
}
