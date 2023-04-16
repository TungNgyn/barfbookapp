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
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.large(
          onPressed: () {
            Get.defaultDialog(
                title: "Rezepte",
                content: Container(
                  height: MediaQuery.of(context).size.height * 0.6,
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Column(
                    children: [
                      Obx(() {
                        List<Widget> list = [];
                        for (Recipe recipe in controller.userLikedRecipe) {
                          list.add(Stack(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    insertSchedule(recipe);
                                  });
                                  Get.back();
                                },
                                child: Card(
                                  child: Container(
                                    height: 250,
                                    width: 250,
                                    child: Padding(
                                        padding: EdgeInsets.all(15),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              recipe.name,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(fontSize: 24),
                                            ),
                                            Container(
                                              height: 128,
                                              width: 128,
                                              child: recipe.avatar,
                                            ),
                                            Spacer(),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                TextButton.icon(
                                                    onPressed: () {
                                                      Get.to(() =>
                                                          ScreenProfile(
                                                              profile: recipe
                                                                  .user!));
                                                    },
                                                    icon: CircleAvatar(
                                                        backgroundColor:
                                                            Colors.transparent,
                                                        radius: 14,
                                                        child:
                                                            recipe.userAvatar),
                                                    label: Text(
                                                        recipe.user!.name)),
                                                TextButton.icon(
                                                    onPressed: () {},
                                                    icon: Image.asset(
                                                      'assets/icons/paw.png',
                                                      width: 48,
                                                    ),
                                                    label: Text(
                                                      '${recipe.paws}',
                                                      style: TextStyle(
                                                          fontSize: 21,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ))
                                              ],
                                            ),
                                          ],
                                        )),
                                  ),
                                ),
                              ),
                              Positioned(
                                  right: 6,
                                  child: IconButton(
                                    icon: Icon(Icons.info_rounded),
                                    onPressed: () {
                                      for (var map
                                          in controller.userLikedRecipeXrefDB) {
                                        if (map?.containsKey("recipe") ??
                                            false) {
                                          if (map['recipe'] == recipe.id) {
                                            Get.to(() => RecipeDetailPage(
                                                  recipe: recipe,
                                                  favorite: true,
                                                ));
                                            return;
                                          }
                                        }
                                      }
                                      Get.to(() => RecipeDetailPage(
                                            recipe: recipe,
                                            favorite: false,
                                          ));
                                      return;
                                    },
                                  ))
                            ],
                          ));
                        }
                        for (Recipe recipe in controller.userRecipeList) {
                          list.add(GestureDetector(
                            onTap: () {
                              Get.to(() => RecipeDetailPage(
                                  recipe: recipe, favorite: true));
                            },
                            child: Card(
                              elevation: 4,
                              child: Padding(
                                  padding: EdgeInsets.only(bottom: 15, top: 10),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Card(
                                          child: Padding(
                                            padding: EdgeInsets.all(10),
                                            child: Container(
                                              height: 128,
                                              width: 128,
                                              child: recipe.avatar,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            recipe.name,
                                            style: TextStyle(fontSize: 21),
                                          ),
                                          TextButton.icon(
                                              onPressed: () {},
                                              icon: Image.asset(
                                                'assets/icons/paw.png',
                                                width: 48,
                                              ),
                                              label: Text(
                                                '${recipe.paws}',
                                                style: TextStyle(
                                                    fontSize: 21,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ))
                                        ],
                                      )
                                    ],
                                  )),
                            ),
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
                                          child: IconButton(
                                            iconSize: 32,
                                            icon: Icon(
                                                Icons.remove_circle_outline),
                                            onPressed: () {
                                              setState(() {
                                                final day = DateTime(
                                                    _selectedDay!.year,
                                                    _selectedDay!.month,
                                                    _selectedDay!.day);
                                                removeValueFromMap(
                                                    kEventSource, day, recipe);
                                              });
                                              print(recipe.scheduleID);
                                              removeSchedule(recipe.scheduleID);
                                            },
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
      print(scheduleID);
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
