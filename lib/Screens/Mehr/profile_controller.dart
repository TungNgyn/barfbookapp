class Profile {
  const Profile({
    required this.id,
    required this.createdAt,
    required this.email,
    required this.name,
    required this.description,
  });

  final String id;
  final String createdAt;
  final String email;
  final String name;
  final String description;
}
