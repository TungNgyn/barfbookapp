import 'package:Barfbook/Screens/Barfbook/barfbook_controller.dart';
import 'package:Barfbook/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

class ScreenSchedule extends StatefulWidget {
  @override
  State<ScreenSchedule> createState() => _ScreenScheduleState();
}

class _ScreenScheduleState extends State<ScreenSchedule> {
  final Controller controller = Get.find();

  DateTime? _selectedDay;
  DateTime? _focusedDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                  title: Text(
                "Planer",
                style: TextStyle(fontSize: 31),
              ))
            ];
          },
          body: SafeArea(
              child: Center(
            child: TableCalendar(
              locale: 'de_DE',
              firstDay: DateTime.utc(2020, 01, 01),
              lastDay: DateTime.utc(2029, 12, 31),
              focusedDay: DateTime.now(),
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay; // update `_focusedDay` here as well
                });
                print(selectedDay);
                print(focusedDay);
              },
              calendarFormat: CalendarFormat.month,
            ),
          ))),
    );
  }
}
