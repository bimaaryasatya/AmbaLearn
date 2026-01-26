class User {
  final String id;
  final String username;
  final String email;
  final String picture;
  final String? organizationId;
  final String? organizationName;
  final DateTime? birthday;
  final DateTime? registeredAt;
  final DateTime? lastLogin;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.picture,
    this.organizationId,
    this.organizationName,
    this.birthday,
    this.registeredAt,
    this.lastLogin,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? '',
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      picture: json['picture'] ?? '',
      organizationId: json['organization_id']?.toString(), // Nullable
      organizationName: json['organization_name'], // Nullable
      birthday: json['birthday'] != null
          ? DateTime.parse(json['birthday'])
          : null,
      registeredAt: json['registered_at'] != null
          ? DateTime.parse(json['registered_at'])
          : null,
      lastLogin: json['last_login'] != null
          ? DateTime.parse(json['last_login'])
          : null,
    );
  }
}
