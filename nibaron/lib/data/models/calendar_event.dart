class CalendarEvent {
  final String id;
  final String title;
  final String description;
  final DateTime date;
  final String category;
  final String priority;
  final bool isCompleted;
  final String? location;
  final List<String>? tags;

  CalendarEvent({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.category,
    this.priority = 'Medium',
    this.isCompleted = false,
    this.location,
    this.tags,
  });

  CalendarEvent copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? date,
    String? category,
    String? priority,
    bool? isCompleted,
    String? location,
    List<String>? tags,
  }) {
    return CalendarEvent(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      date: date ?? this.date,
      category: category ?? this.category,
      priority: priority ?? this.priority,
      isCompleted: isCompleted ?? this.isCompleted,
      location: location ?? this.location,
      tags: tags ?? this.tags,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date.toIso8601String(),
      'category': category,
      'priority': priority,
      'isCompleted': isCompleted,
      'location': location,
      'tags': tags,
    };
  }

  factory CalendarEvent.fromJson(Map<String, dynamic> json) {
    return CalendarEvent(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      date: DateTime.parse(json['date']),
      category: json['category'],
      priority: json['priority'] ?? 'Medium',
      isCompleted: json['isCompleted'] ?? false,
      location: json['location'],
      tags: json['tags']?.cast<String>(),
    );
  }
}
