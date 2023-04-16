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
  Future? _future;
  var kEvents;
  final kEventSource = <DateTime, List>{};

  Future initSchedule() async {
    kEventSource.clear();
    try {
      for (var schedule in controller.scheduleRecipeList) {
        var recipeAvatar;
        try {
          recipeAvatar = CachedNetworkImage(
            imageUrl:
                'https://wokqzyqvqztmyzhhuqqh.supabase.co/storage/v1/object/public/recipe/${schedule.recipe}',
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                CircularProgressIndicator(value: downloadProgress.progress),
            errorWidget: (context, url, error) => Icon(Icons.error),
            imageBuilder: (context, imageProvider) {
              return Container(
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  border:
                      Border.all(color: Theme.of(context).colorScheme.primary),
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          );
        } catch (error) {
          recipeAvatar = CachedNetworkImage(
            imageUrl:
                'https://wokqzyqvqztmyzhhuqqh.supabase.co/storage/v1/object/public/recipe/defaultRecipeAvatar',
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                CircularProgressIndicator(value: downloadProgress.progress),
            errorWidget: (context, url, error) => Icon(Icons.error),
            imageBuilder: (context, imageProvider) {
              return Container(
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  border:
                      Border.all(color: Theme.of(context).colorScheme.primary),
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          );
        }
        final userAvatar = CachedNetworkImage(
          imageUrl:
              'https://wokqzyqvqztmyzhhuqqh.supabase.co/storage/v1/object/public/profile/${schedule.user}',
          progressIndicatorBuilder: (context, url, downloadProgress) =>
              CircularProgressIndicator(value: downloadProgress.progress),
          errorWidget: (context, url, error) => Icon(Icons.error),
          imageBuilder: (context, imageProvider) {
            return Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border:
                    Border.all(color: Theme.of(context).colorScheme.primary),
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        );

        final recipe = await supabase
            .from('recipe')
            .select('*')
            .eq('id', schedule.recipe)
            .single();
        final user = await supabase
            .from('profile')
            .select('*')
            .eq('id', recipe['user_id'])
            .single();
        kEventSource[schedule.date] = [
          Recipe(
              id: recipe['id'],
              name: recipe['name'],
              description: recipe['description'],
              paws: 0,
              created_at: recipe['created_at'],
              modified_at: recipe['modified_at'],
              user_id: recipe['user_id'],
              avatar: recipeAvatar,
              user: Profile(
                  id: user['id'],
                  createdAt: user['created_at'],
                  email: user['email'],
                  name: user['name'],
                  description: user['description'],
                  avatar: userAvatar),
              userAvatar: userAvatar)
        ];
        kEventSource[DateTime(2023, 04, 18)] = [
          Recipe(
              id: recipe['id'],
              name: recipe['name'],
              description: recipe['description'],
              paws: 4,
              created_at: recipe['created_at'],
              modified_at: recipe['modified_at'],
              user_id: recipe['user_id'],
              avatar: recipeAvatar,
              user: Profile(
                  id: user['id'],
                  createdAt: user['created_at'],
                  email: user['email'],
                  name: user['name'],
                  description: user['description'],
                  avatar: userAvatar),
              userAvatar: userAvatar)
        ];
      }
    } catch (error) {
      print(error);
    }
  }

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

    _future = initSchedule().whenComplete(() => setState(() {
          kEvents = LinkedHashMap<DateTime, List>(
            equals: isSameDay,
            hashCode: getHashCode,
          )..addAll(kEventSource);
          print(kEventSource);

          _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
          _selectedDay = _focusedDay;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _future,
        builder: (context, snapshot) => snapshot.connectionState ==
                ConnectionState.done
            ? Scaffold(
                appBar: AppBar(
                  title: Text("Planer"),
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
                          selectedDayPredicate: (day) =>
                              isSameDay(_selectedDay, day),
                          onDaySelected: _onDaySelected,
                          calendarFormat: CalendarFormat.month,
                          onPageChanged: (focusedDay) {
                            _focusedDay = focusedDay;
                          },
                          eventLoader: (day) => _getEventsForDay(day)),
                      Text("Rezepte"),
                      Expanded(
                          child: ValueListenableBuilder(
                        valueListenable: _selectedEvents,
                        builder: (context, value, child) {
                          return ListView.builder(
                            itemCount: value.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                  title: GestureDetector(
                                onTap: () {
                                  for (var map
                                      in controller.userLikedRecipeXrefDB) {
                                    if (map?.containsKey("recipe") ?? false) {
                                      if (map['recipe'] == value[index].id) {
                                        Get.to(() => RecipeDetailPage(
                                              recipe: value[index],
                                              favorite: true,
                                            ));
                                        return;
                                      }
                                    }
                                  }
                                  Get.to(() => RecipeDetailPage(
                                        recipe: value[index],
                                        favorite: false,
                                      ));
                                  return;
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
                                              value[index].name,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(fontSize: 24),
                                            ),
                                            Container(
                                              height: 128,
                                              width: 128,
                                              child: value[index].avatar,
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
                                                              profile:
                                                                  value[index]
                                                                      .user));
                                                    },
                                                    icon: CircleAvatar(
                                                        backgroundColor:
                                                            Colors.transparent,
                                                        radius: 14,
                                                        child: value[index]
                                                            .userAvatar),
                                                    label: Text(value[index]
                                                        .user
                                                        .name)),
                                                TextButton.icon(
                                                    onPressed: () {},
                                                    icon: Image.asset(
                                                      'assets/icons/paw.png',
                                                      width: 48,
                                                    ),
                                                    label: Text(
                                                      '${value[index].paws}',
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
                              ));
                            },
                          );
                        },
                      )),
                    ],
                  ),
                ),
              )
            : Center(
                child: CircularProgressIndicator(),
              ));
  }
}
