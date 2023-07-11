import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  //final TextTheme textTheme = Theme.of(context).textTheme;
  final DateTime _startDay = DateTime(1800);
  final DateTime _endDay = DateTime(3000);
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      // Call `setState()` when updating the selected day
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });
    }
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
            firstDay: _startDay,
            lastDay: _endDay,
            focusedDay: _focusedDay,
            rowHeight: 38,
            //eventLoader: _getEventsForDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: onDaySelected,
            onPageChanged: (focusedDay) {
              // No need to call `setState()` here
              _focusedDay = focusedDay;
            },
          ),
          const SizedBox(
            height: 8.0,
          ),
          ElevatedButton(onPressed: () {}, child: const Text('ADD')),
        ],
      ),
    );
  }
}
