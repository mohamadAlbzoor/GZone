class User {
  final String id;

  final String email;
  final String password;
  final String username;
  User({
    required this.id,
    required this.email,
    required this.password,
    required this.username,
  });

  static User fromJson(Map<String, dynamic> json) => User(
        id: json['id'],
        email: json['email'],
        password: json['password'],
        username: json['username'],
      );
}
