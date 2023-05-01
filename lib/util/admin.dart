import 'package:Barfbook/main.dart';
import 'package:Barfbook/util/Supabase/AuthController.dart';
import 'package:Barfbook/util/database/database.dart';
import 'package:drift_db_viewer/drift_db_viewer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Admin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin Panel"),
      ),
      body: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "You shouldn't see this!",
                style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
              ),
              ElevatedButton(
                  onPressed: () {
                    Get.to(() => DriftDbViewer(database));
                  },
                  child: Text("Table View")),
              ElevatedButton(
                  onPressed: () async {
                    Dbprofile a = await (database.select(database.dbprofiles)
                          ..where((tbl) => tbl.id.equals(user!.id)))
                        .getSingle();
                    print(a.id);
                  },
                  child: Text("Select"))
            ],
          ),
        ],
      ),
    );
  }
}
