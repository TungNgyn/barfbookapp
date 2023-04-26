import 'dart:collection';

import 'package:Barfbook/Screens/Barfbook/Barfbook.dart';
import 'package:Barfbook/Screens/Barfbook/barfbook_controller.dart';
import 'package:Barfbook/Screens/Mehr/profile.dart';
import 'package:Barfbook/Screens/Mehr/profile_controller.dart';
import 'package:Barfbook/Screens/explore/explore.dart';
import 'package:Barfbook/Screens/explore/recipeDetailPage.dart';
import 'package:Barfbook/Screens/schedule/schedule_controller.dart';
import 'package:Barfbook/controller.dart';
import 'package:Barfbook/util/Supabase/AuthController.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

class ScreenSchedule extends StatefulWidget {
  @override
  State<ScreenSchedule> createState() => _ScreenScheduleState();
}

class _ScreenScheduleState extends State<ScreenSchedule> {
  final Controller controller = Get.find();

  late final ValueNotifier<List> _selectedEvents;
  DateTime? _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  List _getEventsForDay(DateTime day) {
    return kEvents[day] ?? [];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });
      setState(() {
        _selectedEvents.value = _getEventsForDay(selectedDay);
      });
    }
  }

  @override
  void initState() {
    super.initState();

    setState(() {
      kEvents = LinkedHashMap<DateTime, List>(
        equals: isSameDay,
        hashCode: getHashCode,
      )..addAll(kEventSource);

      _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
      _selectedDay = _focusedDay;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.defaultDialog(
                title: "Rezepte",
                content: Container(
                  height: MediaQuery.of(context).size.height * 0.7,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: ListView(
                    children: [
                      Obx(() {
                        List<Widget> list = [];
                        for (Recipe recipe in controller.userLikedRecipe) {
                          list.add(Stack(
                            children: [
                              RecipeCard(
                                  controller: controller, recipe: recipe),
                              Positioned(
                                  right: 6,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        color: Theme.of(context)
                                            .colorScheme
                                            .surface,
                                        shape: BoxShape.circle),
                                    child: IconButton(
                                      padding: EdgeInsets.zero,
                                      icon: Icon(Icons.add),
                                      onPressed: () {
                                        setState(() {
                                          insertSchedule(recipe);
                                        });
                                        Get.back();
                                      },
                                    ),
                                  ))
                            ],
                          ));
                        }
                        for (Recipe recipe in controller.userRecipeList) {
                          list.add(Stack(
                            children: [
                              RecipeCard(
                                  controller: controller, recipe: recipe),
                              Positioned(
                                  right: 6,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        color: Theme.of(context)
                                            .colorScheme
                                            .surface,
                                        shape: BoxShape.circle),
                                    child: IconButton(
                                      padding: EdgeInsets.zero,
                                      icon: Icon(Icons.add),
                                      onPressed: () {
                                        setState(() {
                                          insertSchedule(recipe);
                                        });
                                        Get.back();
                                      },
                                    ),
                                  ))
                            ],
                          ));
                        }
                        return Column(children: list);
                      }),
                    ],
                  ),
                ));
          },
          child: Icon(Icons.add),
        ),
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Planer",
            style: TextStyle(fontSize: 31),
          ),
        ),
        body: Center(
          child: Column(
            children: [
              TableCalendar(
                  headerStyle: HeaderStyle(
                      formatButtonVisible: false, titleCentered: true),
                  locale: 'de_DE',
                  firstDay: DateTime.utc(2020, 01, 01),
                  lastDay: DateTime.utc(2029, 12, 31),
                  focusedDay: _focusedDay,
                  startingDayOfWeek: StartingDayOfWeek.monday,
                  selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                  onDaySelected: _onDaySelected,
                  calendarFormat: CalendarFormat.month,
                  weekendDays: [],
                  onPageChanged: (focusedDay) {
                    _focusedDay = focusedDay;
                  },
                  rowHeight: 40,
                  eventLoader: (day) => _getEventsForDay(day)),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Text(
                  "Mahlzeiten",
                  style: TextStyle(fontSize: 24),
                ),
              ),
              Column(
                children: [
                  ValueListenableBuilder(
                    valueListenable: _selectedEvents,
                    builder: (context, value, child) {
                      return Wrap(
                        children: [
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                for (var recipe in value)
                                  Stack(
                                    children: [
                                      RecipeCard(
                                          controller: controller,
                                          recipe: recipe),
                                      Positioned(
                                          right: 5,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.grey),
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .surface,
                                                shape: BoxShape.circle),
                                            child: IconButton(
                                              padding: EdgeInsets.zero,
                                              iconSize: 24,
                                              icon: Icon(Icons.remove),
                                              onPressed: () {
                                                setState(() {
                                                  final day = DateTime(
                                                      _selectedDay!.year,
                                                      _selectedDay!.month,
                                                      _selectedDay!.day);
                                                  removeValueFromMap(
                                                      kEventSource,
                                                      day,
                                                      recipe);
                                                });
                                                print(recipe.scheduleID);
                                                removeSchedule(
                                                    recipe.scheduleID);
                                              },
                                            ),
                                          )),
                                    ],
                                  ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  void addValueToMap<K, V>(Map<K, List<V>> map, K key, V value) =>
      map.update(key, (list) => list..add(value), ifAbsent: () => [value]);

  void removeValueFromMap<K, V>(Map<K, List<V>> map, K key, V value) {
    if (map.containsKey(key)) {
      map[key]!.remove(value);
      if (map[key]!.isEmpty) {
        map.remove(key);
      }
    }
  }

  void insertSchedule(var recipe) async {
    try {
      final scheduleID = await supabase.rpc('insert_schedule', params: {
        'datevalue': _selectedDay!.toIso8601String(),
        'uservalue': user!.id,
        'recipevalue': recipe.id
      });
      final userAvatar = loadUserAvatar(recipe.user_id);
      final recipeAvatar = loadRecipeAvatar(recipe.id);
      final day =
          DateTime(_selectedDay!.year, _selectedDay!.month, _selectedDay!.day);
      addValueToMap(
          kEventSource,
          day,
          Recipe(
              id: recipe.id,
              name: recipe.name,
              description: recipe.description,
              paws: recipe.paws,
              created_at: recipe.created_at,
              modified_at: recipe.modified_at,
              user_id: recipe.user_id,
              user: Profile(
                  id: recipe.user!.id,
                  createdAt: recipe.user!.createdAt,
                  email: recipe.user!.email,
                  name: recipe.user!.name,
                  description: recipe.user!.description,
                  avatar: userAvatar),
              userAvatar: userAvatar,
              avatar: recipeAvatar,
              scheduleID: scheduleID));

      kEvents = LinkedHashMap<DateTime, List>(
        equals: isSameDay,
        hashCode: getHashCode,
      )..addAll(kEventSource);

      _selectedEvents.value = _getEventsForDay(_selectedDay!);
    } catch (error) {
      print(error);
    }
  }

  void removeSchedule(var schedule) async {
    try {
      await supabase.from('schedule').delete().eq('id', schedule);
    } catch (error) {
      print(error);
    }
  }
}
