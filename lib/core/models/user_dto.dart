class User {
  final int id;
  final String name;
  final String email;
  final String? phone;
  final String? profilePictureUrl;

  // Constructor with required and optional fields
  User({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    this.profilePictureUrl,
  });

  // Factory method to create a User instance from JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      profilePictureUrl: json['profilePictureUrl'],
    );
  }

  // Method to convert a User instance into JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'profilePictureUrl': profilePictureUrl,
    };
  }
}
