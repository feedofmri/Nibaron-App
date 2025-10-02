import 'package:flutter_riverpod/flutter_riverpod.dart';

class NavigationNotifier extends StateNotifier<int> {
  NavigationNotifier() : super(0);

  void setIndex(int index) {
    state = index;
  }

  void goToHome() => setIndex(0);
  void goToCalendar() => setIndex(1);
  void goToRecommendations() => setIndex(2);
  void goToActionLog() => setIndex(3);
  void goToProfile() => setIndex(4);
}

final navigationProvider = StateNotifierProvider<NavigationNotifier, int>((ref) {
  return NavigationNotifier();
});
