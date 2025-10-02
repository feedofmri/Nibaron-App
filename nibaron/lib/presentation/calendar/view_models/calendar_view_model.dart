import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/calendar_event.dart';

class CalendarState {
  final List<CalendarEvent> events;
  final bool isLoading;
  final String? error;

  CalendarState({
    this.events = const [],
    this.isLoading = false,
    this.error,
  });

  CalendarState copyWith({
    List<CalendarEvent>? events,
    bool? isLoading,
    String? error,
  }) {
    return CalendarState(
      events: events ?? this.events,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class CalendarViewModel extends StateNotifier<CalendarState> {
  CalendarViewModel() : super(CalendarState());

  Future<void> loadEvents() async {
    state = state.copyWith(isLoading: true);

    try {
      // Simulate loading events - replace with actual API call
      await Future.delayed(const Duration(seconds: 1));

      final mockEvents = [
        CalendarEvent(
          id: '1',
          title: 'Plant Tomatoes',
          description: 'Plant tomato seedlings in the main field',
          date: DateTime.now().add(const Duration(days: 1)),
          category: 'Planting',
          priority: 'High',
        ),
        CalendarEvent(
          id: '2',
          title: 'Water Plants',
          description: 'Regular watering schedule for all crops',
          date: DateTime.now().add(const Duration(days: 2)),
          category: 'Watering',
          priority: 'Medium',
        ),
        CalendarEvent(
          id: '3',
          title: 'Fertilize Crops',
          description: 'Apply organic fertilizer to vegetable garden',
          date: DateTime.now().add(const Duration(days: 5)),
          category: 'Fertilizing',
          priority: 'Medium',
        ),
      ];

      state = state.copyWith(
        events: mockEvents,
        isLoading: false,
        error: null,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  void addEvent(CalendarEvent event) {
    final updatedEvents = [...state.events, event];
    state = state.copyWith(events: updatedEvents);
  }

  void updateEvent(CalendarEvent updatedEvent) {
    final updatedEvents = state.events.map((event) {
      return event.id == updatedEvent.id ? updatedEvent : event;
    }).toList();
    state = state.copyWith(events: updatedEvents);
  }

  void deleteEvent(String eventId) {
    final updatedEvents = state.events.where((event) => event.id != eventId).toList();
    state = state.copyWith(events: updatedEvents);
  }
}

final calendarViewModelProvider = StateNotifierProvider<CalendarViewModel, CalendarState>((ref) {
  return CalendarViewModel();
});
