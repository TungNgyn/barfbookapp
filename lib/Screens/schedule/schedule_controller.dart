import 'dart:collection';

import 'package:Barfbook/controller.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

class Event {
  final String title;

  const Event(this.title);

  @override
  String toString() => title;
}

final kEvents = LinkedHashMap<DateTime, List<Event>>(
  equals: isSameDay,
  hashCode: getHashCode,
)..addAll(_kEventSource);

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

final Controller controller = Get.find();
// final _kEventSource = Map.fromIterable(controller.exploreRecipeList);
final _kEventSource = {
  DateTime.now(): [Event('Test'), Event('ABC')]
};
