import 'package:drift/drift.dart';
import 'dart:io';

import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

// assuming that your file is called filename.dart. This will give an error at
// first, but it's needed for drift to know about the generated code
part 'database.g.dart';

class Ingredients extends Table {
  IntColumn get id => integer()();
  TextColumn get name => text()();
  TextColumn get category => text()();
  TextColumn get type => text()();
  RealColumn get calories => real()();
  RealColumn get protein => real()();
  RealColumn get fat => real()();
  RealColumn get carbohydrates => real()();
  RealColumn get minerals => real()();
  RealColumn get moisture => real()();
  TextColumn get avatar => text()();
  IntColumn get gram => integer()();

  @override
  Set<Column> get primaryKey => {id};
}

class Pets extends Table {
  IntColumn get id => integer()();
  TextColumn get owner => text()();
  TextColumn get name => text()();
  TextColumn get breed => text()();
  IntColumn get age => integer()();
  IntColumn get weight => integer()();
  TextColumn get gender => text()();
  RealColumn get ration => real()();

  @override
  Set<Column> get primaryKey => {id};
}

class Dogs extends Table {
  IntColumn get id => integer()();
  TextColumn get name => text()();
  TextColumn get avatar => text()();

  @override
  Set<Column> get primaryKey => {id};
}

class Profiles extends Table {
  TextColumn get id => text()();
  DateTimeColumn get createdAt => dateTime()();
  TextColumn get email => text()();
  TextColumn get name => text()();
  TextColumn get description => text()();
  TextColumn get rank => text()();

  @override
  Set<Column> get primaryKey => {id};
}

class Recipes extends Table {
  IntColumn get id => integer()();
  DateTimeColumn get createdAt => dateTime()();
  TextColumn get name => text()();
  TextColumn get description => text()();
  TextColumn get userId => text()();
  IntColumn get paws => integer()();
  DateTimeColumn get modifiedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class LikedRecipes extends Table {
  TextColumn get profile => text()();
  IntColumn get recipe => integer()();

  @override
  Set<Column> get primaryKey => {profile, recipe};
}

class RecipeComments extends Table {
  IntColumn get id => integer()();
  DateTimeColumn get createdAt => dateTime()();
  IntColumn get recipe => integer()();
  DateTimeColumn get modifiedAt => dateTime()();
  TextColumn get profile => text()();
  TextColumn get comment => text()();

  @override
  Set<Column> get primaryKey => {id};
}

class RecipeIngredients extends Table {
  IntColumn get recipe => integer()();
  TextColumn get ingredient => text()();
  IntColumn get gram => integer()();

  @override
  Set<Column> get primaryKey => {recipe, ingredient};
}

class Schedules extends Table {
  IntColumn get id => integer()();
  DateTimeColumn get date => dateTime()();
  IntColumn get recipe => integer()();
  TextColumn get userId => text()();

  @override
  Set<Column> get primaryKey => {date, recipe};
}

// this annotation tells drift to prepare a database class that uses both of the
// tables we just defined. We'll see how to use that database class in a moment.
@DriftDatabase(tables: [
  Ingredients,
  Pets,
  Profiles,
  Recipes,
  Schedules,
  LikedRecipes,
  Dogs,
  RecipeComments,
  RecipeIngredients
])
class BarfbookDatabase extends _$BarfbookDatabase {
  BarfbookDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
