import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../config/theme/text_styles.dart';
import '../../../config/theme/app_colors.dart';
import '../../../data/models/action_log_entry.dart';
import '../view_models/action_log_view_model.dart';
import '../widgets/action_log_card.dart';
import '../widgets/filter_chip_group.dart';
import '../widgets/add_log_dialog.dart';

class ActionLogScreen extends ConsumerStatefulWidget {
  const ActionLogScreen({super.key});

  @override
  ConsumerState<ActionLogScreen> createState() => _ActionLogScreenState();
}

class _ActionLogScreenState extends ConsumerState<ActionLogScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  String _selectedFilter = 'All';
  final List<String> _filterOptions = [
    'All',
    'Planting',
    'Watering',
    'Fertilizing',
    'Harvesting',
    'Pest Control',
    'Maintenance'
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(actionLogViewModelProvider.notifier).loadActionLogs();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final actionLogState = ref.watch(actionLogViewModelProvider);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.actionHistory),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => _showSearchDialog(context),
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => _showFilterDialog(context),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: [
            Tab(text: l10n.recent, icon: const Icon(Icons.access_time)),
            Tab(text: l10n.thisWeek, icon: const Icon(Icons.calendar_view_week)),
            Tab(text: l10n.thisMonth, icon: const Icon(Icons.calendar_view_month)),
          ],
        ),
      ),
      body: Column(
        children: [
          // Filter Chips
          Container(
            padding: const EdgeInsets.all(16),
            child: FilterChipGroup(
              options: _filterOptions,
              selectedOption: _selectedFilter,
              onChanged: (value) {
                setState(() {
                  _selectedFilter = value;
                });
                ref.read(actionLogViewModelProvider.notifier).filterLogs(value);
              },
            ),
          ),

          // Search Bar (if active)
          if (_searchController.text.isNotEmpty)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: l10n.searchActivities,
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      _searchController.clear();
                      ref.read(actionLogViewModelProvider.notifier).searchLogs('');
                      setState(() {});
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onChanged: (value) {
                  ref.read(actionLogViewModelProvider.notifier).searchLogs(value);
                },
              ),
            ),

          // Tab View
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildLogList(actionLogState.recentLogs),
                _buildLogList(actionLogState.weeklyLogs),
                _buildLogList(actionLogState.monthlyLogs),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddLogDialog(context),
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildLogList(List<ActionLogEntry> logs) {
    if (logs.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.assignment_outlined,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'No activities recorded',
              style: TextStyles.body1.copyWith(
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 8),
            TextButton.icon(
              onPressed: () => _showAddLogDialog(context),
              icon: const Icon(Icons.add),
              label: const Text('Add Activity'),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        await ref.read(actionLogViewModelProvider.notifier).loadActionLogs();
      },
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: logs.length,
        itemBuilder: (context, index) {
          final log = logs[index];
          return ActionLogCard(
            log: log,
            onTap: () => Navigator.pushNamed(
              context,
              '/log-detail',
              arguments: log,
            ),
            onEdit: () => _showEditLogDialog(context, log),
            onDelete: () => _deleteLog(log),
          );
        },
      ),
    );
  }

  void _showSearchDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Search Activities'),
        content: TextField(
          controller: _searchController,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'Enter search term...',
            border: OutlineInputBorder(),
          ),
          onChanged: (value) {
            ref.read(actionLogViewModelProvider.notifier).searchLogs(value);
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              _searchController.clear();
              ref.read(actionLogViewModelProvider.notifier).searchLogs('');
              Navigator.pop(context);
              setState(() {});
            },
            child: const Text('Clear'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Done'),
          ),
        ],
      ),
    );
  }

  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Filter Activities'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: _filterOptions.map((option) {
            return RadioListTile<String>(
              title: Text(option),
              value: option,
              groupValue: _selectedFilter,
              onChanged: (value) {
                setState(() {
                  _selectedFilter = value!;
                });
                ref.read(actionLogViewModelProvider.notifier).filterLogs(value!);
                Navigator.pop(context);
              },
            );
          }).toList(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void _showAddLogDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AddLogDialog(
        onSave: (log) {
          ref.read(actionLogViewModelProvider.notifier).addLog(log);
        },
      ),
    );
  }

  void _showEditLogDialog(BuildContext context, ActionLogEntry log) {
    showDialog(
      context: context,
      builder: (context) => AddLogDialog(
        log: log,
        onSave: (updatedLog) {
          ref.read(actionLogViewModelProvider.notifier).updateLog(updatedLog);
        },
      ),
    );
  }

  void _deleteLog(ActionLogEntry log) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Activity'),
        content: Text('Are you sure you want to delete "${log.title}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              ref.read(actionLogViewModelProvider.notifier).deleteLog(log.id);
              Navigator.pop(context);
            },
            child: const Text('Delete'),
            style: TextButton.styleFrom(
              foregroundColor: AppColors.error,
            ),
          ),
        ],
      ),
    );
  }
}
