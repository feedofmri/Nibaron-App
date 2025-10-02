import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/action_log_entry.dart';

class ActionLogState {
  final List<ActionLogEntry> allLogs;
  final List<ActionLogEntry> filteredLogs;
  final List<ActionLogEntry> recentLogs;
  final List<ActionLogEntry> weeklyLogs;
  final List<ActionLogEntry> monthlyLogs;
  final bool isLoading;
  final String? error;
  final String searchQuery;
  final String selectedFilter;

  ActionLogState({
    this.allLogs = const [],
    this.filteredLogs = const [],
    this.recentLogs = const [],
    this.weeklyLogs = const [],
    this.monthlyLogs = const [],
    this.isLoading = false,
    this.error,
    this.searchQuery = '',
    this.selectedFilter = 'All',
  });

  ActionLogState copyWith({
    List<ActionLogEntry>? allLogs,
    List<ActionLogEntry>? filteredLogs,
    List<ActionLogEntry>? recentLogs,
    List<ActionLogEntry>? weeklyLogs,
    List<ActionLogEntry>? monthlyLogs,
    bool? isLoading,
    String? error,
    String? searchQuery,
    String? selectedFilter,
  }) {
    return ActionLogState(
      allLogs: allLogs ?? this.allLogs,
      filteredLogs: filteredLogs ?? this.filteredLogs,
      recentLogs: recentLogs ?? this.recentLogs,
      weeklyLogs: weeklyLogs ?? this.weeklyLogs,
      monthlyLogs: monthlyLogs ?? this.monthlyLogs,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedFilter: selectedFilter ?? this.selectedFilter,
    );
  }
}

class ActionLogViewModel extends StateNotifier<ActionLogState> {
  ActionLogViewModel() : super(ActionLogState());

  Future<void> loadActionLogs() async {
    state = state.copyWith(isLoading: true);

    try {
      // Simulate loading logs - replace with actual API call
      await Future.delayed(const Duration(seconds: 1));

      final mockLogs = [
        ActionLogEntry(
          id: '1',
          title: 'Watered Tomato Plants',
          description: 'Applied 10L water to tomato section',
          timestamp: DateTime.now().subtract(const Duration(hours: 2)),
          category: 'Watering',
          duration: 0.5,
          location: 'Field A',
        ),
        ActionLogEntry(
          id: '2',
          title: 'Harvested Carrots',
          description: 'Collected 5kg carrots from main field',
          timestamp: DateTime.now().subtract(const Duration(days: 1)),
          category: 'Harvesting',
          duration: 1.5,
          location: 'Field B',
        ),
        ActionLogEntry(
          id: '3',
          title: 'Applied Fertilizer',
          description: 'Organic compost application',
          timestamp: DateTime.now().subtract(const Duration(days: 3)),
          category: 'Fertilizing',
          duration: 2.0,
          location: 'Field A',
        ),
        ActionLogEntry(
          id: '4',
          title: 'Pest Control Treatment',
          description: 'Applied neem oil spray for aphids',
          timestamp: DateTime.now().subtract(const Duration(days: 7)),
          category: 'Pest Control',
          duration: 1.0,
          location: 'Greenhouse',
        ),
      ];

      final now = DateTime.now();
      final oneWeekAgo = now.subtract(const Duration(days: 7));
      final oneMonthAgo = now.subtract(const Duration(days: 30));

      final recentLogs = mockLogs.where((log) =>
        log.timestamp.isAfter(now.subtract(const Duration(days: 3)))).toList();
      final weeklyLogs = mockLogs.where((log) =>
        log.timestamp.isAfter(oneWeekAgo)).toList();
      final monthlyLogs = mockLogs.where((log) =>
        log.timestamp.isAfter(oneMonthAgo)).toList();

      state = state.copyWith(
        allLogs: mockLogs,
        filteredLogs: mockLogs,
        recentLogs: recentLogs,
        weeklyLogs: weeklyLogs,
        monthlyLogs: monthlyLogs,
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

  void addLog(ActionLogEntry log) {
    final updatedLogs = [log, ...state.allLogs];
    state = state.copyWith(allLogs: updatedLogs);
    _updateFilteredLogs();
  }

  void updateLog(ActionLogEntry updatedLog) {
    final updatedLogs = state.allLogs.map((log) {
      return log.id == updatedLog.id ? updatedLog : log;
    }).toList();
    state = state.copyWith(allLogs: updatedLogs);
    _updateFilteredLogs();
  }

  void deleteLog(String logId) {
    final updatedLogs = state.allLogs.where((log) => log.id != logId).toList();
    state = state.copyWith(allLogs: updatedLogs);
    _updateFilteredLogs();
  }

  void filterLogs(String filter) {
    state = state.copyWith(selectedFilter: filter);
    _updateFilteredLogs();
  }

  void searchLogs(String query) {
    state = state.copyWith(searchQuery: query);
    _updateFilteredLogs();
  }

  void _updateFilteredLogs() {
    var filtered = state.allLogs;

    // Apply category filter
    if (state.selectedFilter != 'All') {
      filtered = filtered.where((log) => log.category == state.selectedFilter).toList();
    }

    // Apply search filter
    if (state.searchQuery.isNotEmpty) {
      filtered = filtered.where((log) =>
          log.title.toLowerCase().contains(state.searchQuery.toLowerCase()) ||
          log.description.toLowerCase().contains(state.searchQuery.toLowerCase())).toList();
    }

    final now = DateTime.now();
    final oneWeekAgo = now.subtract(const Duration(days: 7));
    final oneMonthAgo = now.subtract(const Duration(days: 30));

    final recentLogs = filtered.where((log) =>
      log.timestamp.isAfter(now.subtract(const Duration(days: 3)))).toList();
    final weeklyLogs = filtered.where((log) =>
      log.timestamp.isAfter(oneWeekAgo)).toList();
    final monthlyLogs = filtered.where((log) =>
      log.timestamp.isAfter(oneMonthAgo)).toList();

    state = state.copyWith(
      filteredLogs: filtered,
      recentLogs: recentLogs,
      weeklyLogs: weeklyLogs,
      monthlyLogs: monthlyLogs,
    );
  }
}

final actionLogViewModelProvider = StateNotifierProvider<ActionLogViewModel, ActionLogState>((ref) {
  return ActionLogViewModel();
});
