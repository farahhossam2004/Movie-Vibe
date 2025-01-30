class User {
  final String id;
  final String username;
  final String email;

  User({
    required this.id,
    required this.username,
    required this.email,
  });

  // Factory method to create a User from JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'], // MongoDB uses '_id' as the default ID field
      username: json['username'],
      email: json['email'],
    );
  }
}