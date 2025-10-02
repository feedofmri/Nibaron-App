import 'package:json_annotation/json_annotation.dart';

part 'recommendation_model.g.dart';

@JsonSerializable()
class RecommendationModel {
  final String id;
  final String farmId;
  final String cropId;
  final String title;
  final String description;
  final String category; // irrigation, fertilizer, pest_control, harvest, planting
  final String priority; // low, medium, high, critical
  final DateTime recommendedDate;
  final DateTime? expiryDate;
  final String? audioUrl;
  final Map<String, dynamic>? additionalData;
  final bool isCompleted;
  final DateTime? completedAt;
  final String? userFeedback;
  final int? rating;
  final DateTime createdAt;
  final DateTime updatedAt;

  RecommendationModel({
    required this.id,
    required this.farmId,
    required this.cropId,
    required this.title,
    required this.description,
    required this.category,
    this.priority = 'medium',
    required this.recommendedDate,
    this.expiryDate,
    this.audioUrl,
    this.additionalData,
    this.isCompleted = false,
    this.completedAt,
    this.userFeedback,
    this.rating,
    required this.createdAt,
    required this.updatedAt,
  });

  factory RecommendationModel.fromJson(Map<String, dynamic> json) =>
      _$RecommendationModelFromJson(json);

  Map<String, dynamic> toJson() => _$RecommendationModelToJson(this);

  RecommendationModel copyWith({
    String? id,
    String? farmId,
    String? cropId,
    String? title,
    String? description,
    String? category,
    String? priority,
    DateTime? recommendedDate,
    DateTime? expiryDate,
    String? audioUrl,
    Map<String, dynamic>? additionalData,
    bool? isCompleted,
    DateTime? completedAt,
    String? userFeedback,
    int? rating,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return RecommendationModel(
      id: id ?? this.id,
      farmId: farmId ?? this.farmId,
      cropId: cropId ?? this.cropId,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      priority: priority ?? this.priority,
      recommendedDate: recommendedDate ?? this.recommendedDate,
      expiryDate: expiryDate ?? this.expiryDate,
      audioUrl: audioUrl ?? this.audioUrl,
      additionalData: additionalData ?? this.additionalData,
      isCompleted: isCompleted ?? this.isCompleted,
      completedAt: completedAt ?? this.completedAt,
      userFeedback: userFeedback ?? this.userFeedback,
      rating: rating ?? this.rating,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  bool get isOverdue {
    if (expiryDate == null) return false;
    return DateTime.now().isAfter(expiryDate!) && !isCompleted;
  }

  bool get isUrgent {
    return priority == 'high' || priority == 'critical';
  }

  String get priorityText {
    switch (priority) {
      case 'low':
        return 'কম গুরুত্বপূর্ণ';
      case 'medium':
        return 'মাঝারি গুরুত্বপূর্ণ';
      case 'high':
        return 'বেশি গুরুত্বপূর্ণ';
      case 'critical':
        return 'অত্যন্ত জরুরি';
      default:
        return 'মাঝারি গুরুত্বপূর্ণ';
    }
  }

  String get categoryText {
    switch (category) {
      case 'irrigation':
        return 'সেচ';
      case 'fertilizer':
        return 'সার';
      case 'pest_control':
        return 'কীটনাশক';
      case 'harvest':
        return 'ফসল কাটা';
      case 'planting':
        return 'রোপণ';
      default:
        return 'অন্যান্য';
    }
  }
}
