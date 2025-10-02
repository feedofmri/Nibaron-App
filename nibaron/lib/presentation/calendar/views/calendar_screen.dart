import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../config/theme/text_styles.dart';
import '../../../config/theme/app_colors.dart';
import '../../../data/models/calendar_event.dart';
import '../view_models/calendar_view_model.dart';
import '../widgets/event_card.dart';
import '../widgets/add_event_dialog.dart';

class CalendarScreen extends ConsumerStatefulWidget {
  const CalendarScreen({super.key});

  @override
  ConsumerState<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends ConsumerState<CalendarScreen> {
  late final ValueNotifier<List<CalendarEvent>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOff;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime.now();
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(calendarViewModelProvider.notifier).loadEvents();
    });
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<CalendarEvent> _getEventsForDay(DateTime day) {
    final calendarState = ref.read(calendarViewModelProvider);
    return calendarState.events.where((event) => isSameDay(event.date, day)).toList();
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeStart = null;
        _rangeEnd = null;
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
      });

      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.farmingCalendar),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.today),
            onPressed: () {
              setState(() {
                _focusedDay = DateTime.now();
                _selectedDay = DateTime.now();
              });
              _selectedEvents.value = _getEventsForDay(DateTime.now());
            },
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showAddEventDialog(context),
          ),
        ],
      ),
      body: Column(
        children: [
          // Calendar Widget
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withValues(alpha: 0.1),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: TableCalendar<CalendarEvent>(
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: _focusedDay,
              calendarFormat: _calendarFormat,
              rangeSelectionMode: _rangeSelectionMode,
              eventLoader: _getEventsForDay,
              startingDayOfWeek: StartingDayOfWeek.monday,
              // Fix day names cropping with proper styling
              daysOfWeekHeight: 40,
              rowHeight: 48,
              daysOfWeekStyle: DaysOfWeekStyle(
                weekdayStyle: TextStyles.bodyMedium.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.w600,
                  height: 1.2,
                ),
                weekendStyle: TextStyles.bodyMedium.copyWith(
                  color: AppColors.error,
                  fontWeight: FontWeight.w600,
                  height: 1.2,
                ),
              ),
              calendarStyle: CalendarStyle(
                outsideDaysVisible: false,
                weekendTextStyle: TextStyles.body2.copyWith(color: AppColors.error),
                holidayTextStyle: TextStyles.body2.copyWith(color: AppColors.error),
                defaultTextStyle: TextStyles.body2.copyWith(
                  height: 1.2,
                ),
                selectedDecoration: BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                todayDecoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.5),
                  shape: BoxShape.circle,
                ),
                markersMaxCount: 3,
                markerDecoration: BoxDecoration(
                  color: AppColors.secondary,
                  shape: BoxShape.circle,
                ),
                // Add proper cell padding to prevent cropping
                cellPadding: const EdgeInsets.all(6.0),
                cellAlignment: Alignment.center,
              ),
              headerStyle: HeaderStyle(
                formatButtonVisible: true,
                titleCentered: true,
                formatButtonShowsNext: false,
                formatButtonDecoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                formatButtonTextStyle: const TextStyle(
                  color: Colors.white,
                ),
              ),
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              rangeStartDay: _rangeStart,
              rangeEndDay: _rangeEnd,
              onDaySelected: _onDaySelected,
              onRangeSelected: (start, end, focusedDay) {
                setState(() {
                  _selectedDay = null;
                  _focusedDay = focusedDay;
                  _rangeStart = start;
                  _rangeEnd = end;
                  _rangeSelectionMode = RangeSelectionMode.toggledOn;
                });
              },
              onFormatChanged: (format) {
                if (_calendarFormat != format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                }
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
            ),
          ),

          const SizedBox(height: 8.0),

          // Events List
          Expanded(
            child: ValueListenableBuilder<List<CalendarEvent>>(
              valueListenable: _selectedEvents,
              builder: (context, value, _) {
                if (value.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.event_busy,
                          size: 64,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No events for this day',
                          style: TextStyles.body1.copyWith(
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextButton.icon(
                          onPressed: () => _showAddEventDialog(context),
                          icon: const Icon(Icons.add),
                          label: Text(l10n.addTask),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: value.length,
                  itemBuilder: (context, index) {
                    final event = value[index];
                    return EventCard(
                      event: event,
                      onTap: () => Navigator.pushNamed(
                        context,
                        '/event-detail',
                        arguments: event,
                      ),
                      onEdit: () => _showEditEventDialog(context, event),
                      onDelete: () => _deleteEvent(event),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showAddEventDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AddEventDialog(
        selectedDate: _selectedDay ?? DateTime.now(),
        onSave: (event) {
          ref.read(calendarViewModelProvider.notifier).addEvent(event);
          _selectedEvents.value = _getEventsForDay(_selectedDay ?? DateTime.now());
        },
      ),
    );
  }

  void _showEditEventDialog(BuildContext context, CalendarEvent event) {
    showDialog(
      context: context,
      builder: (context) => AddEventDialog(
        selectedDate: event.date,
        event: event,
        onSave: (updatedEvent) {
          ref.read(calendarViewModelProvider.notifier).updateEvent(updatedEvent);
          _selectedEvents.value = _getEventsForDay(_selectedDay ?? DateTime.now());
        },
      ),
    );
  }

  void _deleteEvent(CalendarEvent event) {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.delete),
        content: Text('${l10n.areYouSure} "${event.title}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () {
              ref.read(calendarViewModelProvider.notifier).deleteEvent(event.id);
              _selectedEvents.value = _getEventsForDay(_selectedDay ?? DateTime.now());
              Navigator.pop(context);
            },
            child: Text(l10n.delete),
          ),
        ],
      ),
    );
  }
}
