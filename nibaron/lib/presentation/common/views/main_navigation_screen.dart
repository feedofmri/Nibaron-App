import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../config/theme/app_colors.dart';
import '../../home/views/home_screen.dart';
import '../../calendar/views/calendar_screen.dart';
import '../../recommendations/views/recommendations_screen.dart';
import '../../action_log/views/action_log_screen.dart';
import '../../profile/views/profile_screen.dart';
import '../providers/navigation_provider.dart';

class MainNavigationScreen extends ConsumerWidget {
  const MainNavigationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(navigationProvider);

    final List<Widget> screens = [
      const HomeScreen(),
      const CalendarScreen(),
      const RecommendationsScreen(),
      const ActionLogScreen(),
      const ProfileScreen(),
    ];

    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: screens,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) {
            ref.read(navigationProvider.notifier).setIndex(index);
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: Theme.of(context).colorScheme.surface,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
          selectedLabelStyle: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w400,
          ),
          items: [
            BottomNavigationBarItem(
              icon: _buildNavIcon(Icons.home_outlined, Icons.home, 0, currentIndex),
              label: l10n.home,
            ),
            BottomNavigationBarItem(
              icon: _buildNavIcon(Icons.calendar_today_outlined, Icons.calendar_today, 1, currentIndex),
              label: l10n.calendar,
            ),
            BottomNavigationBarItem(
              icon: _buildNavIcon(Icons.lightbulb_outline, Icons.lightbulb, 2, currentIndex),
              label: l10n.recommendations,
            ),
            BottomNavigationBarItem(
              icon: _buildNavIcon(Icons.assignment_outlined, Icons.assignment, 3, currentIndex),
              label: l10n.actionLog,
            ),
            BottomNavigationBarItem(
              icon: _buildNavIcon(Icons.person_outline, Icons.person, 4, currentIndex),
              label: l10n.profile,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavIcon(IconData outlinedIcon, IconData filledIcon, int index, int currentIndex) {
    final isSelected = index == currentIndex;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primary.withValues(alpha: 0.1) : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(
        isSelected ? filledIcon : outlinedIcon,
        size: 24,
      ),
    );
  }
}
