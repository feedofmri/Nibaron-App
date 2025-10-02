// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crop_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CropModel _$CropModelFromJson(Map<String, dynamic> json) => CropModel(
      id: json['id'] as String,
      farmId: json['farmId'] as String,
      name: json['name'] as String,
      type: json['type'] as String,
      variety: json['variety'] as String,
      plantingDate: DateTime.parse(json['plantingDate'] as String),
      expectedHarvestDate: json['expectedHarvestDate'] == null
          ? null
          : DateTime.parse(json['expectedHarvestDate'] as String),
      growthStage: json['growthStage'] as String? ?? 'seedling',
      plantedArea: (json['plantedArea'] as num).toDouble(),
      plantedAreaUnit: json['plantedAreaUnit'] as String? ?? 'acre',
      status: json['status'] as String? ?? 'active',
      additionalInfo: json['additionalInfo'] as Map<String, dynamic>?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$CropModelToJson(CropModel instance) => <String, dynamic>{
      'id': instance.id,
      'farmId': instance.farmId,
      'name': instance.name,
      'type': instance.type,
      'variety': instance.variety,
      'plantingDate': instance.plantingDate.toIso8601String(),
      'expectedHarvestDate': instance.expectedHarvestDate?.toIso8601String(),
      'growthStage': instance.growthStage,
      'plantedArea': instance.plantedArea,
      'plantedAreaUnit': instance.plantedAreaUnit,
      'status': instance.status,
      'additionalInfo': instance.additionalInfo,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
