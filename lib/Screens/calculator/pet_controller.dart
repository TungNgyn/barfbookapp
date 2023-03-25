class Pet {
  const Pet(
      {required this.id,
      required this.owner,
      required this.name,
      this.breed = 'keine Angabe',
      this.age = 0,
      this.weight = 0,
      this.ration = 3,
      this.gender = 'rüde'});

  final int id;
  final String owner;
  final String name;
  final String breed;
  final int age;
  final int weight;
  final String gender;
  final double ration;
}
