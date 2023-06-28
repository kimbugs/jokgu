import 'package:flutter/material.dart';
import 'package:flutter_application_firebase/models/game_model.dart';
import 'package:flutter_application_firebase/screens/game_detail_screen.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  late final ValueNotifier<List<GameModel>> _selectedEvents;
  final DateTime startDay = DateTime(1800);
  final DateTime endDay = DateTime(3000);
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();

    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }

  @override
  void dispose() {
    _selectedEvents.dispose();

    super.dispose();
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      // Call `setState()` when updating the selected day
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });

      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  List<GameModel> _getEventsForDay(DateTime day) {
    return events[day] ?? [];
  }

  void onButtonTap() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const GameDetailScreen(),
        fullscreenDialog: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TableCalendar(
            headerStyle: const HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
            ),
            calendarStyle: const CalendarStyle(
              markersMaxCount: 1,
              weekendTextStyle: TextStyle(
                color: Colors.red,
              ),
            ),
            locale: 'ko-KR',
            daysOfWeekHeight: 30,
            firstDay: startDay,
            lastDay: endDay,
            focusedDay: _focusedDay,
            rowHeight: 38,
            eventLoader: _getEventsForDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: _onDaySelected,
            onPageChanged: (focusedDay) {
              // No need to call `setState()` here
              _focusedDay = focusedDay;
            },
          ),
          const SizedBox(height: 8.0),
          Expanded(
            child: _gameSetList(_selectedEvents),
          ),
        ],
      ),
    );
  }

  ValueListenableBuilder<List<GameModel>> _gameSetList(
      ValueNotifier<List<GameModel>> selectedEvents) {
    return ValueListenableBuilder<List<GameModel>>(
      valueListenable: selectedEvents,
      builder: (context, value, child) {
        return ListView.builder(
          itemCount: value.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: onButtonTap,
              child: Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                    // border: Border.all(),
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.blue.shade100),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        value[index].title,
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                      const Icon(
                        Icons.chevron_right_rounded,
                        color: Colors.black,
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
