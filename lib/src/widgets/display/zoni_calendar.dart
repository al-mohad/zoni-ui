import 'package:flutter/material.dart';
import '../../theme/zoni_colors.dart';

/// Calendar view types.
enum ZoniCalendarView {
  /// Month view showing full month.
  month,
  /// Week view showing single week.
  week,
  /// Day view showing single day.
  day,
  /// Agenda view showing list of events.
  agenda,
}

/// Calendar event data model.
class ZoniCalendarEvent {
  /// Creates a calendar event.
  const ZoniCalendarEvent({
    required this.id,
    required this.title,
    required this.startTime,
    required this.endTime,
    this.description,
    this.location,
    this.color,
    this.isAllDay = false,
    this.isRecurring = false,
    this.attendees = const [],
    this.category,
    this.priority,
    this.onTap,
    this.onEdit,
    this.onDelete,
  });

  /// Unique identifier for the event.
  final String id;

  /// Title of the event.
  final String title;

  /// Start time of the event.
  final DateTime startTime;

  /// End time of the event.
  final DateTime endTime;

  /// Optional description.
  final String? description;

  /// Optional location.
  final String? location;

  /// Color of the event.
  final Color? color;

  /// Whether the event is all day.
  final bool isAllDay;

  /// Whether the event is recurring.
  final bool isRecurring;

  /// List of attendees.
  final List<String> attendees;

  /// Event category.
  final String? category;

  /// Event priority.
  final String? priority;

  /// Callback when event is tapped.
  final VoidCallback? onTap;

  /// Callback when event is edited.
  final VoidCallback? onEdit;

  /// Callback when event is deleted.
  final VoidCallback? onDelete;
}

/// Comprehensive calendar component.
class ZoniCalendar extends StatefulWidget {
  /// Creates a calendar.
  const ZoniCalendar({
    super.key,
    required this.events,
    this.view = ZoniCalendarView.month,
    this.initialDate,
    this.onDateSelected,
    this.onViewChanged,
    this.onEventTap,
    this.onDateTap,
    this.onEventCreate,
    this.eventBuilder,
    this.dayBuilder,
    this.headerBuilder,
    this.weekdayBuilder,
    this.showWeekNumbers = false,
    this.showNavigationButtons = true,
    this.showViewSelector = true,
    this.firstDayOfWeek = DateTime.monday,
    this.weekendDays = const [DateTime.saturday, DateTime.sunday],
    this.holidays = const [],
    this.minDate,
    this.maxDate,
    this.selectedDates = const [],
    this.multiSelectMode = false,
    this.backgroundColor,
    this.headerColor,
    this.selectedDateColor,
    this.todayColor,
    this.weekendColor,
    this.holidayColor,
    this.eventColor,
    this.borderRadius = 8.0,
    this.elevation = 2.0,
    this.padding = const EdgeInsets.all(16.0),
  });

  /// Events to display in the calendar.
  final List<ZoniCalendarEvent> events;

  /// Current view of the calendar.
  final ZoniCalendarView view;

  /// Initial date to display.
  final DateTime? initialDate;

  /// Callback when date is selected.
  final void Function(DateTime date)? onDateSelected;

  /// Callback when view is changed.
  final void Function(ZoniCalendarView view)? onViewChanged;

  /// Callback when event is tapped.
  final void Function(ZoniCalendarEvent event)? onEventTap;

  /// Callback when date is tapped.
  final void Function(DateTime date)? onDateTap;

  /// Callback when new event should be created.
  final void Function(DateTime date)? onEventCreate;

  /// Custom event builder.
  final Widget Function(BuildContext context, ZoniCalendarEvent event)? eventBuilder;

  /// Custom day builder.
  final Widget Function(BuildContext context, DateTime date, List<ZoniCalendarEvent> events)? dayBuilder;

  /// Custom header builder.
  final Widget Function(BuildContext context, DateTime date)? headerBuilder;

  /// Custom weekday builder.
  final Widget Function(BuildContext context, String weekday)? weekdayBuilder;

  /// Whether to show week numbers.
  final bool showWeekNumbers;

  /// Whether to show navigation buttons.
  final bool showNavigationButtons;

  /// Whether to show view selector.
  final bool showViewSelector;

  /// First day of the week.
  final int firstDayOfWeek;

  /// Weekend days.
  final List<int> weekendDays;

  /// Holiday dates.
  final List<DateTime> holidays;

  /// Minimum selectable date.
  final DateTime? minDate;

  /// Maximum selectable date.
  final DateTime? maxDate;

  /// Currently selected dates.
  final List<DateTime> selectedDates;

  /// Whether multi-select mode is enabled.
  final bool multiSelectMode;

  /// Background color of the calendar.
  final Color? backgroundColor;

  /// Header background color.
  final Color? headerColor;

  /// Selected date color.
  final Color? selectedDateColor;

  /// Today's date color.
  final Color? todayColor;

  /// Weekend dates color.
  final Color? weekendColor;

  /// Holiday dates color.
  final Color? holidayColor;

  /// Default event color.
  final Color? eventColor;

  /// Border radius.
  final double borderRadius;

  /// Elevation.
  final double elevation;

  /// Padding around the calendar.
  final EdgeInsets padding;

  @override
  State<ZoniCalendar> createState() => _ZoniCalendarState();
}

class _ZoniCalendarState extends State<ZoniCalendar> {
  late DateTime _currentDate;
  late ZoniCalendarView _currentView;
  late List<DateTime> _selectedDates;

  @override
  void initState() {
    super.initState();
    _currentDate = widget.initialDate ?? DateTime.now();
    _currentView = widget.view;
    _selectedDates = List.from(widget.selectedDates);
  }

  @override
  void didUpdateWidget(ZoniCalendar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedDates != oldWidget.selectedDates) {
      _selectedDates = List.from(widget.selectedDates);
    }
    if (widget.view != oldWidget.view) {
      _currentView = widget.view;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: widget.backgroundColor ?? theme.cardColor,
      elevation: widget.elevation,
      borderRadius: BorderRadius.circular(widget.borderRadius),
      child: Container(
        padding: widget.padding,
        child: Column(
          children: [
            _buildHeader(theme),
            const SizedBox(height: 16.0),
            Expanded(
              child: _buildCalendarView(theme),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(ThemeData theme) {
    if (widget.headerBuilder != null) {
      return widget.headerBuilder!(context, _currentDate);
    }

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: widget.headerColor ?? ZoniColors.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(widget.borderRadius),
      ),
      child: Row(
        children: [
          if (widget.showNavigationButtons) ...[
            IconButton(
              onPressed: _previousPeriod,
              icon: const Icon(Icons.chevron_left),
            ),
            const SizedBox(width: 8.0),
          ],
          Expanded(
            child: Text(
              _getHeaderText(),
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: ZoniColors.primary,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          if (widget.showNavigationButtons) ...[
            const SizedBox(width: 8.0),
            IconButton(
              onPressed: _nextPeriod,
              icon: const Icon(Icons.chevron_right),
            ),
          ],
          if (widget.showViewSelector) ...[
            const SizedBox(width: 16.0),
            DropdownButton<ZoniCalendarView>(
              value: _currentView,
              onChanged: (view) {
                if (view != null) {
                  setState(() => _currentView = view);
                  widget.onViewChanged?.call(view);
                }
              },
              items: ZoniCalendarView.values.map((view) {
                return DropdownMenuItem(
                  value: view,
                  child: Text(_getViewName(view)),
                );
              }).toList(),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildCalendarView(ThemeData theme) {
    switch (_currentView) {
      case ZoniCalendarView.month:
        return _buildMonthView(theme);
      case ZoniCalendarView.week:
        return _buildWeekView(theme);
      case ZoniCalendarView.day:
        return _buildDayView(theme);
      case ZoniCalendarView.agenda:
        return _buildAgendaView(theme);
    }
  }

  Widget _buildMonthView(ThemeData theme) {
    final firstDayOfMonth = DateTime(_currentDate.year, _currentDate.month, 1);
    final lastDayOfMonth = DateTime(_currentDate.year, _currentDate.month + 1, 0);
    final firstDayOfCalendar = _getFirstDayOfCalendar(firstDayOfMonth);
    final lastDayOfCalendar = _getLastDayOfCalendar(lastDayOfMonth);

    final days = <DateTime>[];
    var current = firstDayOfCalendar;
    while (current.isBefore(lastDayOfCalendar) || current.isAtSameMomentAs(lastDayOfCalendar)) {
      days.add(current);
      current = current.add(const Duration(days: 1));
    }

    return Column(
      children: [
        _buildWeekdayHeader(theme),
        const SizedBox(height: 8.0),
        Expanded(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              childAspectRatio: 1.0,
            ),
            itemCount: days.length,
            itemBuilder: (context, index) {
              final date = days[index];
              final events = _getEventsForDate(date);
              return _buildDayCell(theme, date, events);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildWeekdayHeader(ThemeData theme) {
    final weekdays = _getWeekdayNames();
    
    return Row(
      children: weekdays.map((weekday) {
        return Expanded(
          child: widget.weekdayBuilder?.call(context, weekday) ??
              Center(
                child: Text(
                  weekday,
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: theme.textTheme.bodySmall?.color?.withValues(alpha: 0.7),
                  ),
                ),
              ),
        );
      }).toList(),
    );
  }

  Widget _buildDayCell(ThemeData theme, DateTime date, List<ZoniCalendarEvent> events) {
    if (widget.dayBuilder != null) {
      return widget.dayBuilder!(context, date, events);
    }

    final isToday = _isSameDay(date, DateTime.now());
    final isSelected = _selectedDates.any((selected) => _isSameDay(selected, date));
    final isCurrentMonth = date.month == _currentDate.month;
    final isWeekend = widget.weekendDays.contains(date.weekday);
    final isHoliday = widget.holidays.any((holiday) => _isSameDay(holiday, date));

    Color? backgroundColor;
    Color? textColor;

    if (isSelected) {
      backgroundColor = widget.selectedDateColor ?? ZoniColors.primary;
      textColor = Colors.white;
    } else if (isToday) {
      backgroundColor = widget.todayColor ?? ZoniColors.primary.withValues(alpha: 0.2);
      textColor = ZoniColors.primary;
    } else if (isHoliday) {
      backgroundColor = widget.holidayColor ?? ZoniColors.error.withValues(alpha: 0.1);
      textColor = ZoniColors.error;
    } else if (isWeekend) {
      textColor = widget.weekendColor ?? ZoniColors.neutralGray;
    } else if (!isCurrentMonth) {
      textColor = theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.3);
    }

    return GestureDetector(
      onTap: () => _onDateTap(date),
      onLongPress: () => widget.onEventCreate?.call(date),
      child: Container(
        margin: const EdgeInsets.all(2.0),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Text(
                  '${date.day}',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: textColor,
                    fontWeight: isToday || isSelected ? FontWeight.w600 : null,
                  ),
                ),
              ),
            ),
            if (events.isNotEmpty)
              Container(
                height: 4.0,
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Row(
                  children: events.take(3).map((event) {
                    return Expanded(
                      child: Container(
                        height: 4.0,
                        margin: const EdgeInsets.symmetric(horizontal: 1.0),
                        decoration: BoxDecoration(
                          color: event.color ?? widget.eventColor ?? ZoniColors.primary,
                          borderRadius: BorderRadius.circular(2.0),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeekView(ThemeData theme) {
    // Implementation for week view
    return Center(
      child: Text(
        'Week View',
        style: theme.textTheme.titleMedium,
      ),
    );
  }

  Widget _buildDayView(ThemeData theme) {
    // Implementation for day view
    return Center(
      child: Text(
        'Day View',
        style: theme.textTheme.titleMedium,
      ),
    );
  }

  Widget _buildAgendaView(ThemeData theme) {
    final upcomingEvents = widget.events
        .where((event) => event.startTime.isAfter(DateTime.now()))
        .toList()
      ..sort((a, b) => a.startTime.compareTo(b.startTime));

    if (upcomingEvents.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.event_outlined,
              size: 64.0,
              color: theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.3),
            ),
            const SizedBox(height: 16.0),
            Text(
              'No upcoming events',
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.textTheme.titleMedium?.color?.withValues(alpha: 0.7),
              ),
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      itemCount: upcomingEvents.length,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        final event = upcomingEvents[index];
        return _buildEventTile(theme, event);
      },
    );
  }

  Widget _buildEventTile(ThemeData theme, ZoniCalendarEvent event) {
    if (widget.eventBuilder != null) {
      return widget.eventBuilder!(context, event);
    }

    return ListTile(
      leading: Container(
        width: 4.0,
        height: 40.0,
        decoration: BoxDecoration(
          color: event.color ?? widget.eventColor ?? ZoniColors.primary,
          borderRadius: BorderRadius.circular(2.0),
        ),
      ),
      title: Text(
        event.title,
        style: theme.textTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _formatEventTime(event),
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.textTheme.bodySmall?.color?.withValues(alpha: 0.7),
            ),
          ),
          if (event.location != null)
            Text(
              event.location!,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.textTheme.bodySmall?.color?.withValues(alpha: 0.5),
              ),
            ),
        ],
      ),
      onTap: () => widget.onEventTap?.call(event),
    );
  }

  void _onDateTap(DateTime date) {
    if (widget.multiSelectMode) {
      setState(() {
        if (_selectedDates.any((selected) => _isSameDay(selected, date))) {
          _selectedDates.removeWhere((selected) => _isSameDay(selected, date));
        } else {
          _selectedDates.add(date);
        }
      });
    } else {
      setState(() {
        _selectedDates = [date];
      });
    }
    
    widget.onDateSelected?.call(date);
    widget.onDateTap?.call(date);
  }

  void _previousPeriod() {
    setState(() {
      switch (_currentView) {
        case ZoniCalendarView.month:
          _currentDate = DateTime(_currentDate.year, _currentDate.month - 1);
          break;
        case ZoniCalendarView.week:
          _currentDate = _currentDate.subtract(const Duration(days: 7));
          break;
        case ZoniCalendarView.day:
          _currentDate = _currentDate.subtract(const Duration(days: 1));
          break;
        case ZoniCalendarView.agenda:
          _currentDate = DateTime(_currentDate.year, _currentDate.month - 1);
          break;
      }
    });
  }

  void _nextPeriod() {
    setState(() {
      switch (_currentView) {
        case ZoniCalendarView.month:
          _currentDate = DateTime(_currentDate.year, _currentDate.month + 1);
          break;
        case ZoniCalendarView.week:
          _currentDate = _currentDate.add(const Duration(days: 7));
          break;
        case ZoniCalendarView.day:
          _currentDate = _currentDate.add(const Duration(days: 1));
          break;
        case ZoniCalendarView.agenda:
          _currentDate = DateTime(_currentDate.year, _currentDate.month + 1);
          break;
      }
    });
  }

  String _getHeaderText() {
    switch (_currentView) {
      case ZoniCalendarView.month:
        return '${_getMonthName(_currentDate.month)} ${_currentDate.year}';
      case ZoniCalendarView.week:
        final startOfWeek = _getStartOfWeek(_currentDate);
        final endOfWeek = startOfWeek.add(const Duration(days: 6));
        return '${_formatDate(startOfWeek)} - ${_formatDate(endOfWeek)}';
      case ZoniCalendarView.day:
        return _formatDate(_currentDate);
      case ZoniCalendarView.agenda:
        return 'Upcoming Events';
    }
  }

  String _getViewName(ZoniCalendarView view) {
    switch (view) {
      case ZoniCalendarView.month:
        return 'Month';
      case ZoniCalendarView.week:
        return 'Week';
      case ZoniCalendarView.day:
        return 'Day';
      case ZoniCalendarView.agenda:
        return 'Agenda';
    }
  }

  List<String> _getWeekdayNames() {
    final weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    final firstDayIndex = widget.firstDayOfWeek - 1;
    return [...weekdays.sublist(firstDayIndex), ...weekdays.sublist(0, firstDayIndex)];
  }

  DateTime _getFirstDayOfCalendar(DateTime firstDayOfMonth) {
    final weekday = firstDayOfMonth.weekday;
    final daysToSubtract = (weekday - widget.firstDayOfWeek) % 7;
    return firstDayOfMonth.subtract(Duration(days: daysToSubtract));
  }

  DateTime _getLastDayOfCalendar(DateTime lastDayOfMonth) {
    final weekday = lastDayOfMonth.weekday;
    final daysToAdd = (widget.firstDayOfWeek + 6 - weekday) % 7;
    return lastDayOfMonth.add(Duration(days: daysToAdd));
  }

  DateTime _getStartOfWeek(DateTime date) {
    final weekday = date.weekday;
    final daysToSubtract = (weekday - widget.firstDayOfWeek) % 7;
    return date.subtract(Duration(days: daysToSubtract));
  }

  List<ZoniCalendarEvent> _getEventsForDate(DateTime date) {
    return widget.events.where((event) {
      return _isSameDay(event.startTime, date) || 
             (event.startTime.isBefore(date) && event.endTime.isAfter(date));
    }).toList();
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  String _getMonthName(int month) {
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return months[month - 1];
  }

  String _formatDate(DateTime date) {
    return '${_getMonthName(date.month)} ${date.day}, ${date.year}';
  }

  String _formatEventTime(ZoniCalendarEvent event) {
    if (event.isAllDay) {
      return 'All day';
    }
    
    final startTime = '${event.startTime.hour}:${event.startTime.minute.toString().padLeft(2, '0')}';
    final endTime = '${event.endTime.hour}:${event.endTime.minute.toString().padLeft(2, '0')}';
    return '$startTime - $endTime';
  }
}
