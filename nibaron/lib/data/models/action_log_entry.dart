class ActionLogEntry {
  final String id;
  final String title;
  final String description;
  final DateTime timestamp;
  final String category;
  final String status;
  final Map<String, dynamic>? metadata;
  final List<String>? images;
  final String? location;
  final double? duration; // in hours

  ActionLogEntry({
    required this.id,
    required this.title,
    required this.description,
    required this.timestamp,
    required this.category,
    this.status = 'Completed',
    this.metadata,
    this.images,
    this.location,
    this.duration,
  });

  ActionLogEntry copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? timestamp,
    String? category,
    String? status,
    Map<String, dynamic>? metadata,
    List<String>? images,
    String? location,
    double? duration,
  }) {
    return ActionLogEntry(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      timestamp: timestamp ?? this.timestamp,
      category: category ?? this.category,
      status: status ?? this.status,
      metadata: metadata ?? this.metadata,
      images: images ?? this.images,
      location: location ?? this.location,
      duration: duration ?? this.duration,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'timestamp': timestamp.toIso8601String(),
      'category': category,
      'status': status,
      'metadata': metadata,
      'images': images,
      'location': location,
      'duration': duration,
    };
  }

  factory ActionLogEntry.fromJson(Map<String, dynamic> json) {
    return ActionLogEntry(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      timestamp: DateTime.parse(json['timestamp']),
      category: json['category'],
      status: json['status'] ?? 'Completed',
      metadata: json['metadata']?.cast<String, dynamic>(),
      images: json['images']?.cast<String>(),
      location: json['location'],
      duration: json['duration']?.toDouble(),
    );
  }
}
