import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  final String id;
  final String phoneNumber;
  final String? name;
  final String? email;
  final String? profileImage;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isActive;
  final String? language;
  final Map<String, dynamic>? preferences;

  UserModel({
    required this.id,
    required this.phoneNumber,
    this.name,
    this.email,
    this.profileImage,
    required this.createdAt,
    required this.updatedAt,
    this.isActive = true,
    this.language = 'bn',
    this.preferences,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  UserModel copyWith({
    String? id,
    String? phoneNumber,
    String? name,
    String? email,
    String? profileImage,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isActive,
    String? language,
    Map<String, dynamic>? preferences,
  }) {
    return UserModel(
      id: id ?? this.id,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      name: name ?? this.name,
      email: email ?? this.email,
      profileImage: profileImage ?? this.profileImage,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isActive: isActive ?? this.isActive,
      language: language ?? this.language,
      preferences: preferences ?? this.preferences,
    );
  }
}
