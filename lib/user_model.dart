class UserModel {
  final String userId;
  final String name;
  final String email;
  final String phone;
  final String role;
  final String flatNumber;
  final String profilePhoto;

  UserModel({
    required this.userId,
    required this.name,
    required this.email,
    required this.phone,
    required this.role,
    required this.flatNumber,
    required this.profilePhoto,
  });

  // Convert Firestore data into UserModel.
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userId: map['userId'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      role: map['role'] ?? '',
      flatNumber: map['flatNumber'] ?? '',
      profilePhoto: map['profilePhoto'] ?? '',
    );
  }

  // Convert UserModel into a Map.
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'name': name,
      'email': email,
      'phone': phone,
      'role': role,
      'flatNumber': flatNumber,
      'profilePhoto': profilePhoto,
    };
  }
}
