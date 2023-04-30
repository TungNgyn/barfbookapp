// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $IngredientsTable extends Ingredients
    with TableInfo<$IngredientsTable, Ingredient> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $IngredientsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 6, maxTextLength: 32),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _categoryMeta =
      const VerificationMeta('category');
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
      'category', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _caloriesMeta =
      const VerificationMeta('calories');
  @override
  late final GeneratedColumn<double> calories = GeneratedColumn<double>(
      'calories', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _proteinMeta =
      const VerificationMeta('protein');
  @override
  late final GeneratedColumn<double> protein = GeneratedColumn<double>(
      'protein', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _fatMeta = const VerificationMeta('fat');
  @override
  late final GeneratedColumn<double> fat = GeneratedColumn<double>(
      'fat', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _farbohydratesMeta =
      const VerificationMeta('farbohydrates');
  @override
  late final GeneratedColumn<double> farbohydrates = GeneratedColumn<double>(
      'farbohydrates', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _mineralsMeta =
      const VerificationMeta('minerals');
  @override
  late final GeneratedColumn<double> minerals = GeneratedColumn<double>(
      'minerals', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _moistureMeta =
      const VerificationMeta('moisture');
  @override
  late final GeneratedColumn<double> moisture = GeneratedColumn<double>(
      'moisture', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _avatarMeta = const VerificationMeta('avatar');
  @override
  late final GeneratedColumn<String> avatar = GeneratedColumn<String>(
      'avatar', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        category,
        type,
        calories,
        protein,
        fat,
        farbohydrates,
        minerals,
        moisture,
        avatar
      ];
  @override
  String get aliasedName => _alias ?? 'ingredients';
  @override
  String get actualTableName => 'ingredients';
  @override
  VerificationContext validateIntegrity(Insertable<Ingredient> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('calories')) {
      context.handle(_caloriesMeta,
          calories.isAcceptableOrUnknown(data['calories']!, _caloriesMeta));
    } else if (isInserting) {
      context.missing(_caloriesMeta);
    }
    if (data.containsKey('protein')) {
      context.handle(_proteinMeta,
          protein.isAcceptableOrUnknown(data['protein']!, _proteinMeta));
    } else if (isInserting) {
      context.missing(_proteinMeta);
    }
    if (data.containsKey('fat')) {
      context.handle(
          _fatMeta, fat.isAcceptableOrUnknown(data['fat']!, _fatMeta));
    } else if (isInserting) {
      context.missing(_fatMeta);
    }
    if (data.containsKey('farbohydrates')) {
      context.handle(
          _farbohydratesMeta,
          farbohydrates.isAcceptableOrUnknown(
              data['farbohydrates']!, _farbohydratesMeta));
    } else if (isInserting) {
      context.missing(_farbohydratesMeta);
    }
    if (data.containsKey('minerals')) {
      context.handle(_mineralsMeta,
          minerals.isAcceptableOrUnknown(data['minerals']!, _mineralsMeta));
    } else if (isInserting) {
      context.missing(_mineralsMeta);
    }
    if (data.containsKey('moisture')) {
      context.handle(_moistureMeta,
          moisture.isAcceptableOrUnknown(data['moisture']!, _moistureMeta));
    } else if (isInserting) {
      context.missing(_moistureMeta);
    }
    if (data.containsKey('avatar')) {
      context.handle(_avatarMeta,
          avatar.isAcceptableOrUnknown(data['avatar']!, _avatarMeta));
    } else if (isInserting) {
      context.missing(_avatarMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Ingredient map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Ingredient(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      category: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      calories: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}calories'])!,
      protein: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}protein'])!,
      fat: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}fat'])!,
      farbohydrates: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}farbohydrates'])!,
      minerals: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}minerals'])!,
      moisture: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}moisture'])!,
      avatar: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}avatar'])!,
    );
  }

  @override
  $IngredientsTable createAlias(String alias) {
    return $IngredientsTable(attachedDatabase, alias);
  }
}

class Ingredient extends DataClass implements Insertable<Ingredient> {
  final int id;
  final String name;
  final String category;
  final String type;
  final double calories;
  final double protein;
  final double fat;
  final double farbohydrates;
  final double minerals;
  final double moisture;
  final String avatar;
  const Ingredient(
      {required this.id,
      required this.name,
      required this.category,
      required this.type,
      required this.calories,
      required this.protein,
      required this.fat,
      required this.farbohydrates,
      required this.minerals,
      required this.moisture,
      required this.avatar});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['category'] = Variable<String>(category);
    map['type'] = Variable<String>(type);
    map['calories'] = Variable<double>(calories);
    map['protein'] = Variable<double>(protein);
    map['fat'] = Variable<double>(fat);
    map['farbohydrates'] = Variable<double>(farbohydrates);
    map['minerals'] = Variable<double>(minerals);
    map['moisture'] = Variable<double>(moisture);
    map['avatar'] = Variable<String>(avatar);
    return map;
  }

  IngredientsCompanion toCompanion(bool nullToAbsent) {
    return IngredientsCompanion(
      id: Value(id),
      name: Value(name),
      category: Value(category),
      type: Value(type),
      calories: Value(calories),
      protein: Value(protein),
      fat: Value(fat),
      farbohydrates: Value(farbohydrates),
      minerals: Value(minerals),
      moisture: Value(moisture),
      avatar: Value(avatar),
    );
  }

  factory Ingredient.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Ingredient(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      category: serializer.fromJson<String>(json['category']),
      type: serializer.fromJson<String>(json['type']),
      calories: serializer.fromJson<double>(json['calories']),
      protein: serializer.fromJson<double>(json['protein']),
      fat: serializer.fromJson<double>(json['fat']),
      farbohydrates: serializer.fromJson<double>(json['farbohydrates']),
      minerals: serializer.fromJson<double>(json['minerals']),
      moisture: serializer.fromJson<double>(json['moisture']),
      avatar: serializer.fromJson<String>(json['avatar']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'category': serializer.toJson<String>(category),
      'type': serializer.toJson<String>(type),
      'calories': serializer.toJson<double>(calories),
      'protein': serializer.toJson<double>(protein),
      'fat': serializer.toJson<double>(fat),
      'farbohydrates': serializer.toJson<double>(farbohydrates),
      'minerals': serializer.toJson<double>(minerals),
      'moisture': serializer.toJson<double>(moisture),
      'avatar': serializer.toJson<String>(avatar),
    };
  }

  Ingredient copyWith(
          {int? id,
          String? name,
          String? category,
          String? type,
          double? calories,
          double? protein,
          double? fat,
          double? farbohydrates,
          double? minerals,
          double? moisture,
          String? avatar}) =>
      Ingredient(
        id: id ?? this.id,
        name: name ?? this.name,
        category: category ?? this.category,
        type: type ?? this.type,
        calories: calories ?? this.calories,
        protein: protein ?? this.protein,
        fat: fat ?? this.fat,
        farbohydrates: farbohydrates ?? this.farbohydrates,
        minerals: minerals ?? this.minerals,
        moisture: moisture ?? this.moisture,
        avatar: avatar ?? this.avatar,
      );
  @override
  String toString() {
    return (StringBuffer('Ingredient(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('type: $type, ')
          ..write('calories: $calories, ')
          ..write('protein: $protein, ')
          ..write('fat: $fat, ')
          ..write('farbohydrates: $farbohydrates, ')
          ..write('minerals: $minerals, ')
          ..write('moisture: $moisture, ')
          ..write('avatar: $avatar')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, category, type, calories, protein,
      fat, farbohydrates, minerals, moisture, avatar);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Ingredient &&
          other.id == this.id &&
          other.name == this.name &&
          other.category == this.category &&
          other.type == this.type &&
          other.calories == this.calories &&
          other.protein == this.protein &&
          other.fat == this.fat &&
          other.farbohydrates == this.farbohydrates &&
          other.minerals == this.minerals &&
          other.moisture == this.moisture &&
          other.avatar == this.avatar);
}

class IngredientsCompanion extends UpdateCompanion<Ingredient> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> category;
  final Value<String> type;
  final Value<double> calories;
  final Value<double> protein;
  final Value<double> fat;
  final Value<double> farbohydrates;
  final Value<double> minerals;
  final Value<double> moisture;
  final Value<String> avatar;
  const IngredientsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.category = const Value.absent(),
    this.type = const Value.absent(),
    this.calories = const Value.absent(),
    this.protein = const Value.absent(),
    this.fat = const Value.absent(),
    this.farbohydrates = const Value.absent(),
    this.minerals = const Value.absent(),
    this.moisture = const Value.absent(),
    this.avatar = const Value.absent(),
  });
  IngredientsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String category,
    required String type,
    required double calories,
    required double protein,
    required double fat,
    required double farbohydrates,
    required double minerals,
    required double moisture,
    required String avatar,
  })  : name = Value(name),
        category = Value(category),
        type = Value(type),
        calories = Value(calories),
        protein = Value(protein),
        fat = Value(fat),
        farbohydrates = Value(farbohydrates),
        minerals = Value(minerals),
        moisture = Value(moisture),
        avatar = Value(avatar);
  static Insertable<Ingredient> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? category,
    Expression<String>? type,
    Expression<double>? calories,
    Expression<double>? protein,
    Expression<double>? fat,
    Expression<double>? farbohydrates,
    Expression<double>? minerals,
    Expression<double>? moisture,
    Expression<String>? avatar,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (category != null) 'category': category,
      if (type != null) 'type': type,
      if (calories != null) 'calories': calories,
      if (protein != null) 'protein': protein,
      if (fat != null) 'fat': fat,
      if (farbohydrates != null) 'farbohydrates': farbohydrates,
      if (minerals != null) 'minerals': minerals,
      if (moisture != null) 'moisture': moisture,
      if (avatar != null) 'avatar': avatar,
    });
  }

  IngredientsCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String>? category,
      Value<String>? type,
      Value<double>? calories,
      Value<double>? protein,
      Value<double>? fat,
      Value<double>? farbohydrates,
      Value<double>? minerals,
      Value<double>? moisture,
      Value<String>? avatar}) {
    return IngredientsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      type: type ?? this.type,
      calories: calories ?? this.calories,
      protein: protein ?? this.protein,
      fat: fat ?? this.fat,
      farbohydrates: farbohydrates ?? this.farbohydrates,
      minerals: minerals ?? this.minerals,
      moisture: moisture ?? this.moisture,
      avatar: avatar ?? this.avatar,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (calories.present) {
      map['calories'] = Variable<double>(calories.value);
    }
    if (protein.present) {
      map['protein'] = Variable<double>(protein.value);
    }
    if (fat.present) {
      map['fat'] = Variable<double>(fat.value);
    }
    if (farbohydrates.present) {
      map['farbohydrates'] = Variable<double>(farbohydrates.value);
    }
    if (minerals.present) {
      map['minerals'] = Variable<double>(minerals.value);
    }
    if (moisture.present) {
      map['moisture'] = Variable<double>(moisture.value);
    }
    if (avatar.present) {
      map['avatar'] = Variable<String>(avatar.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('IngredientsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('type: $type, ')
          ..write('calories: $calories, ')
          ..write('protein: $protein, ')
          ..write('fat: $fat, ')
          ..write('farbohydrates: $farbohydrates, ')
          ..write('minerals: $minerals, ')
          ..write('moisture: $moisture, ')
          ..write('avatar: $avatar')
          ..write(')'))
        .toString();
  }
}

class $PetsTable extends Pets with TableInfo<$PetsTable, Pet> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PetsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _ownerMeta = const VerificationMeta('owner');
  @override
  late final GeneratedColumn<String> owner = GeneratedColumn<String>(
      'owner', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _breedMeta = const VerificationMeta('breed');
  @override
  late final GeneratedColumn<String> breed = GeneratedColumn<String>(
      'breed', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _ageMeta = const VerificationMeta('age');
  @override
  late final GeneratedColumn<int> age = GeneratedColumn<int>(
      'age', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _weightMeta = const VerificationMeta('weight');
  @override
  late final GeneratedColumn<int> weight = GeneratedColumn<int>(
      'weight', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _genderMeta = const VerificationMeta('gender');
  @override
  late final GeneratedColumn<String> gender = GeneratedColumn<String>(
      'gender', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _rationMeta = const VerificationMeta('ration');
  @override
  late final GeneratedColumn<double> ration = GeneratedColumn<double>(
      'ration', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, owner, name, breed, age, weight, gender, ration];
  @override
  String get aliasedName => _alias ?? 'pets';
  @override
  String get actualTableName => 'pets';
  @override
  VerificationContext validateIntegrity(Insertable<Pet> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('owner')) {
      context.handle(
          _ownerMeta, owner.isAcceptableOrUnknown(data['owner']!, _ownerMeta));
    } else if (isInserting) {
      context.missing(_ownerMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('breed')) {
      context.handle(
          _breedMeta, breed.isAcceptableOrUnknown(data['breed']!, _breedMeta));
    } else if (isInserting) {
      context.missing(_breedMeta);
    }
    if (data.containsKey('age')) {
      context.handle(
          _ageMeta, age.isAcceptableOrUnknown(data['age']!, _ageMeta));
    } else if (isInserting) {
      context.missing(_ageMeta);
    }
    if (data.containsKey('weight')) {
      context.handle(_weightMeta,
          weight.isAcceptableOrUnknown(data['weight']!, _weightMeta));
    } else if (isInserting) {
      context.missing(_weightMeta);
    }
    if (data.containsKey('gender')) {
      context.handle(_genderMeta,
          gender.isAcceptableOrUnknown(data['gender']!, _genderMeta));
    } else if (isInserting) {
      context.missing(_genderMeta);
    }
    if (data.containsKey('ration')) {
      context.handle(_rationMeta,
          ration.isAcceptableOrUnknown(data['ration']!, _rationMeta));
    } else if (isInserting) {
      context.missing(_rationMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Pet map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Pet(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      owner: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}owner'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      breed: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}breed'])!,
      age: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}age'])!,
      weight: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}weight'])!,
      gender: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}gender'])!,
      ration: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}ration'])!,
    );
  }

  @override
  $PetsTable createAlias(String alias) {
    return $PetsTable(attachedDatabase, alias);
  }
}

class Pet extends DataClass implements Insertable<Pet> {
  final int id;
  final String owner;
  final String name;
  final String breed;
  final int age;
  final int weight;
  final String gender;
  final double ration;
  const Pet(
      {required this.id,
      required this.owner,
      required this.name,
      required this.breed,
      required this.age,
      required this.weight,
      required this.gender,
      required this.ration});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['owner'] = Variable<String>(owner);
    map['name'] = Variable<String>(name);
    map['breed'] = Variable<String>(breed);
    map['age'] = Variable<int>(age);
    map['weight'] = Variable<int>(weight);
    map['gender'] = Variable<String>(gender);
    map['ration'] = Variable<double>(ration);
    return map;
  }

  PetsCompanion toCompanion(bool nullToAbsent) {
    return PetsCompanion(
      id: Value(id),
      owner: Value(owner),
      name: Value(name),
      breed: Value(breed),
      age: Value(age),
      weight: Value(weight),
      gender: Value(gender),
      ration: Value(ration),
    );
  }

  factory Pet.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Pet(
      id: serializer.fromJson<int>(json['id']),
      owner: serializer.fromJson<String>(json['owner']),
      name: serializer.fromJson<String>(json['name']),
      breed: serializer.fromJson<String>(json['breed']),
      age: serializer.fromJson<int>(json['age']),
      weight: serializer.fromJson<int>(json['weight']),
      gender: serializer.fromJson<String>(json['gender']),
      ration: serializer.fromJson<double>(json['ration']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'owner': serializer.toJson<String>(owner),
      'name': serializer.toJson<String>(name),
      'breed': serializer.toJson<String>(breed),
      'age': serializer.toJson<int>(age),
      'weight': serializer.toJson<int>(weight),
      'gender': serializer.toJson<String>(gender),
      'ration': serializer.toJson<double>(ration),
    };
  }

  Pet copyWith(
          {int? id,
          String? owner,
          String? name,
          String? breed,
          int? age,
          int? weight,
          String? gender,
          double? ration}) =>
      Pet(
        id: id ?? this.id,
        owner: owner ?? this.owner,
        name: name ?? this.name,
        breed: breed ?? this.breed,
        age: age ?? this.age,
        weight: weight ?? this.weight,
        gender: gender ?? this.gender,
        ration: ration ?? this.ration,
      );
  @override
  String toString() {
    return (StringBuffer('Pet(')
          ..write('id: $id, ')
          ..write('owner: $owner, ')
          ..write('name: $name, ')
          ..write('breed: $breed, ')
          ..write('age: $age, ')
          ..write('weight: $weight, ')
          ..write('gender: $gender, ')
          ..write('ration: $ration')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, owner, name, breed, age, weight, gender, ration);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Pet &&
          other.id == this.id &&
          other.owner == this.owner &&
          other.name == this.name &&
          other.breed == this.breed &&
          other.age == this.age &&
          other.weight == this.weight &&
          other.gender == this.gender &&
          other.ration == this.ration);
}

class PetsCompanion extends UpdateCompanion<Pet> {
  final Value<int> id;
  final Value<String> owner;
  final Value<String> name;
  final Value<String> breed;
  final Value<int> age;
  final Value<int> weight;
  final Value<String> gender;
  final Value<double> ration;
  const PetsCompanion({
    this.id = const Value.absent(),
    this.owner = const Value.absent(),
    this.name = const Value.absent(),
    this.breed = const Value.absent(),
    this.age = const Value.absent(),
    this.weight = const Value.absent(),
    this.gender = const Value.absent(),
    this.ration = const Value.absent(),
  });
  PetsCompanion.insert({
    this.id = const Value.absent(),
    required String owner,
    required String name,
    required String breed,
    required int age,
    required int weight,
    required String gender,
    required double ration,
  })  : owner = Value(owner),
        name = Value(name),
        breed = Value(breed),
        age = Value(age),
        weight = Value(weight),
        gender = Value(gender),
        ration = Value(ration);
  static Insertable<Pet> custom({
    Expression<int>? id,
    Expression<String>? owner,
    Expression<String>? name,
    Expression<String>? breed,
    Expression<int>? age,
    Expression<int>? weight,
    Expression<String>? gender,
    Expression<double>? ration,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (owner != null) 'owner': owner,
      if (name != null) 'name': name,
      if (breed != null) 'breed': breed,
      if (age != null) 'age': age,
      if (weight != null) 'weight': weight,
      if (gender != null) 'gender': gender,
      if (ration != null) 'ration': ration,
    });
  }

  PetsCompanion copyWith(
      {Value<int>? id,
      Value<String>? owner,
      Value<String>? name,
      Value<String>? breed,
      Value<int>? age,
      Value<int>? weight,
      Value<String>? gender,
      Value<double>? ration}) {
    return PetsCompanion(
      id: id ?? this.id,
      owner: owner ?? this.owner,
      name: name ?? this.name,
      breed: breed ?? this.breed,
      age: age ?? this.age,
      weight: weight ?? this.weight,
      gender: gender ?? this.gender,
      ration: ration ?? this.ration,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (owner.present) {
      map['owner'] = Variable<String>(owner.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (breed.present) {
      map['breed'] = Variable<String>(breed.value);
    }
    if (age.present) {
      map['age'] = Variable<int>(age.value);
    }
    if (weight.present) {
      map['weight'] = Variable<int>(weight.value);
    }
    if (gender.present) {
      map['gender'] = Variable<String>(gender.value);
    }
    if (ration.present) {
      map['ration'] = Variable<double>(ration.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PetsCompanion(')
          ..write('id: $id, ')
          ..write('owner: $owner, ')
          ..write('name: $name, ')
          ..write('breed: $breed, ')
          ..write('age: $age, ')
          ..write('weight: $weight, ')
          ..write('gender: $gender, ')
          ..write('ration: $ration')
          ..write(')'))
        .toString();
  }
}

class $ProfilesTable extends Profiles with TableInfo<$ProfilesTable, Profile> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProfilesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('PRIMARY KEY'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
      'email', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _rankMeta = const VerificationMeta('rank');
  @override
  late final GeneratedColumn<String> rank = GeneratedColumn<String>(
      'rank', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, createdAt, email, name, description, rank];
  @override
  String get aliasedName => _alias ?? 'profiles';
  @override
  String get actualTableName => 'profiles';
  @override
  VerificationContext validateIntegrity(Insertable<Profile> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('rank')) {
      context.handle(
          _rankMeta, rank.isAcceptableOrUnknown(data['rank']!, _rankMeta));
    } else if (isInserting) {
      context.missing(_rankMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Profile map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Profile(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      email: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}email'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
      rank: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}rank'])!,
    );
  }

  @override
  $ProfilesTable createAlias(String alias) {
    return $ProfilesTable(attachedDatabase, alias);
  }
}

class Profile extends DataClass implements Insertable<Profile> {
  final String id;
  final DateTime createdAt;
  final String email;
  final String name;
  final String description;
  final String rank;
  const Profile(
      {required this.id,
      required this.createdAt,
      required this.email,
      required this.name,
      required this.description,
      required this.rank});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['email'] = Variable<String>(email);
    map['name'] = Variable<String>(name);
    map['description'] = Variable<String>(description);
    map['rank'] = Variable<String>(rank);
    return map;
  }

  ProfilesCompanion toCompanion(bool nullToAbsent) {
    return ProfilesCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      email: Value(email),
      name: Value(name),
      description: Value(description),
      rank: Value(rank),
    );
  }

  factory Profile.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Profile(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      email: serializer.fromJson<String>(json['email']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String>(json['description']),
      rank: serializer.fromJson<String>(json['rank']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'email': serializer.toJson<String>(email),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String>(description),
      'rank': serializer.toJson<String>(rank),
    };
  }

  Profile copyWith(
          {String? id,
          DateTime? createdAt,
          String? email,
          String? name,
          String? description,
          String? rank}) =>
      Profile(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        email: email ?? this.email,
        name: name ?? this.name,
        description: description ?? this.description,
        rank: rank ?? this.rank,
      );
  @override
  String toString() {
    return (StringBuffer('Profile(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('email: $email, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('rank: $rank')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, createdAt, email, name, description, rank);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Profile &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.email == this.email &&
          other.name == this.name &&
          other.description == this.description &&
          other.rank == this.rank);
}

class ProfilesCompanion extends UpdateCompanion<Profile> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<String> email;
  final Value<String> name;
  final Value<String> description;
  final Value<String> rank;
  final Value<int> rowid;
  const ProfilesCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.email = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.rank = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProfilesCompanion.insert({
    required String id,
    required DateTime createdAt,
    required String email,
    required String name,
    required String description,
    required String rank,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        createdAt = Value(createdAt),
        email = Value(email),
        name = Value(name),
        description = Value(description),
        rank = Value(rank);
  static Insertable<Profile> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<String>? email,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? rank,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (email != null) 'email': email,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (rank != null) 'rank': rank,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProfilesCompanion copyWith(
      {Value<String>? id,
      Value<DateTime>? createdAt,
      Value<String>? email,
      Value<String>? name,
      Value<String>? description,
      Value<String>? rank,
      Value<int>? rowid}) {
    return ProfilesCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      email: email ?? this.email,
      name: name ?? this.name,
      description: description ?? this.description,
      rank: rank ?? this.rank,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (rank.present) {
      map['rank'] = Variable<String>(rank.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProfilesCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('email: $email, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('rank: $rank, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RecipesTable extends Recipes with TableInfo<$RecipesTable, Recipe> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RecipesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _modifiedAtMeta =
      const VerificationMeta('modifiedAt');
  @override
  late final GeneratedColumn<DateTime> modifiedAt = GeneratedColumn<DateTime>(
      'modified_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, createdAt, name, description, userId, modifiedAt];
  @override
  String get aliasedName => _alias ?? 'recipes';
  @override
  String get actualTableName => 'recipes';
  @override
  VerificationContext validateIntegrity(Insertable<Recipe> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('modified_at')) {
      context.handle(
          _modifiedAtMeta,
          modifiedAt.isAcceptableOrUnknown(
              data['modified_at']!, _modifiedAtMeta));
    } else if (isInserting) {
      context.missing(_modifiedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Recipe map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Recipe(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
      modifiedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}modified_at'])!,
    );
  }

  @override
  $RecipesTable createAlias(String alias) {
    return $RecipesTable(attachedDatabase, alias);
  }
}

class Recipe extends DataClass implements Insertable<Recipe> {
  final int id;
  final DateTime createdAt;
  final String name;
  final String description;
  final String userId;
  final DateTime modifiedAt;
  const Recipe(
      {required this.id,
      required this.createdAt,
      required this.name,
      required this.description,
      required this.userId,
      required this.modifiedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['name'] = Variable<String>(name);
    map['description'] = Variable<String>(description);
    map['user_id'] = Variable<String>(userId);
    map['modified_at'] = Variable<DateTime>(modifiedAt);
    return map;
  }

  RecipesCompanion toCompanion(bool nullToAbsent) {
    return RecipesCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      name: Value(name),
      description: Value(description),
      userId: Value(userId),
      modifiedAt: Value(modifiedAt),
    );
  }

  factory Recipe.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Recipe(
      id: serializer.fromJson<int>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String>(json['description']),
      userId: serializer.fromJson<String>(json['userId']),
      modifiedAt: serializer.fromJson<DateTime>(json['modifiedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String>(description),
      'userId': serializer.toJson<String>(userId),
      'modifiedAt': serializer.toJson<DateTime>(modifiedAt),
    };
  }

  Recipe copyWith(
          {int? id,
          DateTime? createdAt,
          String? name,
          String? description,
          String? userId,
          DateTime? modifiedAt}) =>
      Recipe(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        name: name ?? this.name,
        description: description ?? this.description,
        userId: userId ?? this.userId,
        modifiedAt: modifiedAt ?? this.modifiedAt,
      );
  @override
  String toString() {
    return (StringBuffer('Recipe(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('userId: $userId, ')
          ..write('modifiedAt: $modifiedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, createdAt, name, description, userId, modifiedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Recipe &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.name == this.name &&
          other.description == this.description &&
          other.userId == this.userId &&
          other.modifiedAt == this.modifiedAt);
}

class RecipesCompanion extends UpdateCompanion<Recipe> {
  final Value<int> id;
  final Value<DateTime> createdAt;
  final Value<String> name;
  final Value<String> description;
  final Value<String> userId;
  final Value<DateTime> modifiedAt;
  const RecipesCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.userId = const Value.absent(),
    this.modifiedAt = const Value.absent(),
  });
  RecipesCompanion.insert({
    this.id = const Value.absent(),
    required DateTime createdAt,
    required String name,
    required String description,
    required String userId,
    required DateTime modifiedAt,
  })  : createdAt = Value(createdAt),
        name = Value(name),
        description = Value(description),
        userId = Value(userId),
        modifiedAt = Value(modifiedAt);
  static Insertable<Recipe> custom({
    Expression<int>? id,
    Expression<DateTime>? createdAt,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? userId,
    Expression<DateTime>? modifiedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (userId != null) 'user_id': userId,
      if (modifiedAt != null) 'modified_at': modifiedAt,
    });
  }

  RecipesCompanion copyWith(
      {Value<int>? id,
      Value<DateTime>? createdAt,
      Value<String>? name,
      Value<String>? description,
      Value<String>? userId,
      Value<DateTime>? modifiedAt}) {
    return RecipesCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      name: name ?? this.name,
      description: description ?? this.description,
      userId: userId ?? this.userId,
      modifiedAt: modifiedAt ?? this.modifiedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (modifiedAt.present) {
      map['modified_at'] = Variable<DateTime>(modifiedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RecipesCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('userId: $userId, ')
          ..write('modifiedAt: $modifiedAt')
          ..write(')'))
        .toString();
  }
}

class $SchedulesTable extends Schedules
    with TableInfo<$SchedulesTable, Schedule> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SchedulesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _recipeMeta = const VerificationMeta('recipe');
  @override
  late final GeneratedColumn<int> recipe = GeneratedColumn<int>(
      'recipe', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, date, recipe, userId];
  @override
  String get aliasedName => _alias ?? 'schedules';
  @override
  String get actualTableName => 'schedules';
  @override
  VerificationContext validateIntegrity(Insertable<Schedule> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('recipe')) {
      context.handle(_recipeMeta,
          recipe.isAcceptableOrUnknown(data['recipe']!, _recipeMeta));
    } else if (isInserting) {
      context.missing(_recipeMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {date, recipe};
  @override
  Schedule map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Schedule(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      recipe: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}recipe'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
    );
  }

  @override
  $SchedulesTable createAlias(String alias) {
    return $SchedulesTable(attachedDatabase, alias);
  }
}

class Schedule extends DataClass implements Insertable<Schedule> {
  final int id;
  final DateTime date;
  final int recipe;
  final String userId;
  const Schedule(
      {required this.id,
      required this.date,
      required this.recipe,
      required this.userId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['date'] = Variable<DateTime>(date);
    map['recipe'] = Variable<int>(recipe);
    map['user_id'] = Variable<String>(userId);
    return map;
  }

  SchedulesCompanion toCompanion(bool nullToAbsent) {
    return SchedulesCompanion(
      id: Value(id),
      date: Value(date),
      recipe: Value(recipe),
      userId: Value(userId),
    );
  }

  factory Schedule.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Schedule(
      id: serializer.fromJson<int>(json['id']),
      date: serializer.fromJson<DateTime>(json['date']),
      recipe: serializer.fromJson<int>(json['recipe']),
      userId: serializer.fromJson<String>(json['userId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'date': serializer.toJson<DateTime>(date),
      'recipe': serializer.toJson<int>(recipe),
      'userId': serializer.toJson<String>(userId),
    };
  }

  Schedule copyWith({int? id, DateTime? date, int? recipe, String? userId}) =>
      Schedule(
        id: id ?? this.id,
        date: date ?? this.date,
        recipe: recipe ?? this.recipe,
        userId: userId ?? this.userId,
      );
  @override
  String toString() {
    return (StringBuffer('Schedule(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('recipe: $recipe, ')
          ..write('userId: $userId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, date, recipe, userId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Schedule &&
          other.id == this.id &&
          other.date == this.date &&
          other.recipe == this.recipe &&
          other.userId == this.userId);
}

class SchedulesCompanion extends UpdateCompanion<Schedule> {
  final Value<int> id;
  final Value<DateTime> date;
  final Value<int> recipe;
  final Value<String> userId;
  final Value<int> rowid;
  const SchedulesCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.recipe = const Value.absent(),
    this.userId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SchedulesCompanion.insert({
    required int id,
    required DateTime date,
    required int recipe,
    required String userId,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        date = Value(date),
        recipe = Value(recipe),
        userId = Value(userId);
  static Insertable<Schedule> custom({
    Expression<int>? id,
    Expression<DateTime>? date,
    Expression<int>? recipe,
    Expression<String>? userId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (recipe != null) 'recipe': recipe,
      if (userId != null) 'user_id': userId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SchedulesCompanion copyWith(
      {Value<int>? id,
      Value<DateTime>? date,
      Value<int>? recipe,
      Value<String>? userId,
      Value<int>? rowid}) {
    return SchedulesCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      recipe: recipe ?? this.recipe,
      userId: userId ?? this.userId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (recipe.present) {
      map['recipe'] = Variable<int>(recipe.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SchedulesCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('recipe: $recipe, ')
          ..write('userId: $userId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$BarfbookDatabase extends GeneratedDatabase {
  _$BarfbookDatabase(QueryExecutor e) : super(e);
  late final $IngredientsTable ingredients = $IngredientsTable(this);
  late final $PetsTable pets = $PetsTable(this);
  late final $ProfilesTable profiles = $ProfilesTable(this);
  late final $RecipesTable recipes = $RecipesTable(this);
  late final $SchedulesTable schedules = $SchedulesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [ingredients, pets, profiles, recipes, schedules];
}
