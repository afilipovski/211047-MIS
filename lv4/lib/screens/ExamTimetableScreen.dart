import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:new_flutter_project/main.dart';
import 'package:new_flutter_project/screens/RouteVisualizationScreen.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:new_flutter_project/models/examSchedule.dart';
import '../models/location.dart';

class ExamTimetableScreen extends StatefulWidget {
  @override
  _ExamTimetableScreenState createState() => _ExamTimetableScreenState();
}

class _ExamTimetableScreenState extends State<ExamTimetableScreen> {
  late Map<String, List<ExamSchedule>> _events = {};
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    _fetchExamSchedules();
  }

  Future<void> _fetchExamSchedules() async {
    List<ExamSchedule> examSchedules = [
      ExamSchedule(
        subject: 'Kalkulus',
        dateTime: DateTime(2025, 01, 11, 10, 0),
        location: Location(name: 'TMF', latitude: 42.0, longitude: 21.0),
        id: '',
      ),
      ExamSchedule(
        subject: 'Diskretna Matematika',
        dateTime: DateTime(2025, 01, 11, 10, 0),
        location: Location(name: 'MASHINSKI', latitude: 42.1, longitude: 21.1),
        id: '',
      ),
      ExamSchedule(
        subject: 'Operativni Sistemi',
        dateTime: DateTime(2025, 01, 11, 10, 0),
        location: Location(name: 'FINKI', latitude: 42.2, longitude: 21.2),
        id: '',
      ),
    ];

    Map<String, List<ExamSchedule>> events = {};

    for (var exam in examSchedules) {
      var date =
          DateTime(exam.dateTime.year, exam.dateTime.month, exam.dateTime.day);
      var dateKey = date.toIso8601String().substring(0, 10);

      if (!events.containsKey(dateKey)) {
        events[dateKey] = [];
      }
      events[dateKey]!.add(exam);
      try {
        await scheduleExamNotification(
          flutterLocalNotificationsPlugin,
          exam.dateTime,
          exam.subject,
        );
      } catch (e) {
        print('Error scheduling notifications: $e');
      }
    }

    setState(() {
      _events = events;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Испити'),
        backgroundColor: Colors.black,
      ),
      body: TableCalendar(
        focusedDay: _focusedDay,
        firstDay: DateTime(_focusedDay.year, _focusedDay.month - 1, 1),
        lastDay: DateTime(_focusedDay.year, _focusedDay.month + 1, 0),
        calendarFormat: CalendarFormat.month,
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
          });

          var dateKey = selectedDay.toIso8601String().substring(0, 10);
          var events = _events[dateKey] ?? [];

          if (events.isNotEmpty) {
            _showExamPopup(context, _events[dateKey]!);
          }
        },
        eventLoader: (day) {
          var dateKey = day.toIso8601String().substring(0, 10);
          return _events[dateKey] ?? [];
        },
        calendarStyle: CalendarStyle(
          todayDecoration: BoxDecoration(
            color: Colors.redAccent,
            shape: BoxShape.circle,
          ),
          selectedDecoration: BoxDecoration(
            color: Colors.blueAccent,
            shape: BoxShape.circle,
          ),
          markerDecoration: BoxDecoration(
            color: Colors.blueAccent,
            shape: BoxShape.circle,
          ),
        ),
        headerStyle: const HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
        ),
      ),
    );
  }

  void _showExamPopup(BuildContext context, List<ExamSchedule> exams) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Испити на датумот'),
          content: SingleChildScrollView(
            child: Column(
              children: exams.map((exam) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Предмет: ${exam.subject}',
                      ),
                      Text(
                        'Време: ${DateFormat('HH:mm').format(exam.dateTime)}',
                      ),
                      Text(
                        'Локација: ${exam.location.name}',
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RouteVisualizationScreen(
                                  location: exam.location),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text('Мапа'),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Затвори'),
            ),
          ],
        );
      },
    );
  }
}
