import 'dart:collection';

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
        appBar: AppBar(
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
                  eventLoader: (day) => _getEventsForDay(day)),
              Text(
                "Rezepte",
                style: TextStyle(fontSize: 24),
              ),
              Expanded(
                  child: ValueListenableBuilder(
                valueListenable: _selectedEvents,
                builder: (context, value, child) {
                  return Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              for (var recipe in value)
                                Stack(
                                  children: [
                                    RecipeCard(
                                        controller: controller, recipe: recipe),
                                    Positioned(
                                        right: 5,
                                        child: IconButton(
                                          iconSize: 32,
                                          icon:
                                              Icon(Icons.remove_circle_outline),
                                          onPressed: () {
                                            setState(() {
                                              // for (var valueRecipe in value) {
                                              //   if (valueRecipe.id ==
                                              //       recipe.id) {
                                              final day = DateTime(
                                                  _selectedDay!.year,
                                                  _selectedDay!.month,
                                                  _selectedDay!.day);
                                              //     kEventSource[day]
                                              //         ?.remove(recipe);
                                              //   }
                                              // }
                                              removeValueFromMap(
                                                  kEventSource, day, recipe);
                                            });
                                          },
                                        )),
                                  ],
                                ),
                              Center(
                                child: FloatingActionButton.large(
                                  onPressed: () {
                                    final userAvatar = loadUserAvatar(
                                        'a6e4e653-f505-4290-8f3d-3aa328c50acb');
                                    final recipeAvatar = loadRecipeAvatar(5);
                                    setState(() {
                                      addValueToMap(
                                          kEventSource,
                                          DateTime(2023, 4, 16),
                                          Recipe(
                                              id: 5,
                                              name: "name",
                                              description: "description",
                                              paws: 20,
                                              created_at: "created_at",
                                              modified_at: "modified_at",
                                              user_id: "user_id",
                                              user: Profile(
                                                  id: "id",
                                                  createdAt: "createdAt",
                                                  email: "email",
                                                  name: "name",
                                                  description: "description",
                                                  avatar: userAvatar),
                                              userAvatar: userAvatar,
                                              avatar: recipeAvatar));

                                      // kEvents = LinkedHashMap<DateTime, List>(
                                      //   equals: isSameDay,
                                      //   hashCode: getHashCode,
                                      // )..addAll(kEventSource);
                                    });
                                  },
                                  child: Icon(Icons.add),
                                ),
                              )

                              // ListTile(
                              //     title: GestureDetector(
                              //   onTap: () {
                              //     for (var map
                              //         in controller.userLikedRecipeXrefDB) {
                              //       if (map?.containsKey("recipe") ?? false) {
                              //         if (map['recipe'] == value[index].id) {
                              //           Get.to(() => RecipeDetailPage(
                              //                 recipe: value[index],
                              //                 favorite: true,
                              //               ));
                              //           return;
                              //         }
                              //       }
                              //     }
                              //     Get.to(() => RecipeDetailPage(
                              //           recipe: value[index],
                              //           favorite: false,
                              //         ));
                              //     return;
                              //   },
                              //   child: Card(
                              //     child: Container(
                              //       height: 250,
                              //       width: 250,
                              //       child: Padding(
                              //           padding: EdgeInsets.all(15),
                              //           child: Column(
                              //             crossAxisAlignment:
                              //                 CrossAxisAlignment.start,
                              //             children: [
                              //               Text(
                              //                 value[index].name,
                              //                 overflow: TextOverflow.ellipsis,
                              //                 style: TextStyle(fontSize: 24),
                              //               ),
                              //               Container(
                              //                 height: 128,
                              //                 width: 128,
                              //                 child: value[index].avatar,
                              //               ),
                              //               Spacer(),
                              //               Row(
                              //                 mainAxisAlignment:
                              //                     MainAxisAlignment
                              //                         .spaceBetween,
                              //                 children: [
                              //                   TextButton.icon(
                              //                       onPressed: () {
                              //                         Get.to(() =>
                              //                             ScreenProfile(
                              //                                 profile:
                              //                                     value[index]
                              //                                         .user));
                              //                       },
                              //                       icon: CircleAvatar(
                              //                           backgroundColor:
                              //                               Colors.transparent,
                              //                           radius: 14,
                              //                           child: value[index]
                              //                               .userAvatar),
                              //                       label: Text(value[index]
                              //                           .user
                              //                           .name)),
                              //                   TextButton.icon(
                              //                       onPressed: () {},
                              //                       icon: Image.asset(
                              //                         'assets/icons/paw.png',
                              //                         width: 48,
                              //                       ),
                              //                       label: Text(
                              //                         '${value[index].paws}',
                              //                         style: TextStyle(
                              //                             fontSize: 21,
                              //                             fontWeight:
                              //                                 FontWeight.bold),
                              //                       ))
                              //                 ],
                              //               ),
                              //             ],
                              //           )),
                              //     ),
                              //   ),
                              // )),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              )),
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
}
