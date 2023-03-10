import 'package:Barfbook/util/Supabase/AuthController.dart';
import 'package:flutter/material.dart';

class ScreenCreateSchedule extends StatefulWidget {
  const ScreenCreateSchedule({super.key});

  @override
  State<ScreenCreateSchedule> createState() => _newScheduleState();
}

const enumWeek = {
  1: "Montag",
  2: "Dienstag",
  3: "Mittwoch",
  4: "Donnerstag",
  5: "Freitag",
  6: "Samstag",
  7: "Sonntag",
};

late var scheduledata;

Future<void> getSchedule() async {
  try {
    scheduledata = await supabase.from('schedule').select('day, recipe');
  } catch (error) {
    print("ERROR = $error");
  }
}

class _newScheduleState extends State<ScreenCreateSchedule> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Neuen Wochenplan erstellen"),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(
                icon: Icon(Icons.add),
                onPressed: () {},
              ),
            )
          ],
        ),
        body: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                child: SizedBox(
                  height: 100,
                  child: Card(
                      elevation: 10,
                      child: Column(
                        children: [
                          Row(children: [Text("data")]),
                          Row(children: [Text("2222")])
                        ],
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                child: SizedBox(
                  height: 100,
                  child: Card(
                      elevation: 10,
                      child: Column(
                        children: [
                          Row(children: [Text("data")]),
                          Row(children: [Text("2222")])
                        ],
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                child: SizedBox(
                  height: 100,
                  child: Card(
                      elevation: 10,
                      child: Column(
                        children: [
                          Row(children: [Text("data")]),
                          Row(children: [Text("2222")])
                        ],
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                child: SizedBox(
                  height: 100,
                  child: Card(
                      elevation: 10,
                      child: Column(
                        children: [
                          Row(children: [Text("data")]),
                          Row(children: [Text("2222")])
                        ],
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                child: SizedBox(
                  height: 100,
                  child: Card(
                      elevation: 10,
                      child: Column(
                        children: [
                          Row(children: [Text("data")]),
                          Row(children: [Text("2222")])
                        ],
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                child: SizedBox(
                  height: 100,
                  child: Card(
                      elevation: 10,
                      child: Column(
                        children: [
                          Row(children: [Text("data")]),
                          Row(children: [Text("2222")])
                        ],
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                child: SizedBox(
                  height: 100,
                  child: Card(
                      elevation: 10,
                      child: Column(
                        children: [
                          Row(children: [Text("data")]),
                          Row(children: [Text("2222")])
                        ],
                      )),
                ),
              ),
            ],
          ),
        ));
  }
}
