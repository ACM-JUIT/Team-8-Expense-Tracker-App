

class UserModel {
  final String uid;
  final String name;
  final String email;
  final String avatar;
  final double budget;
  final String phoneNumber;
  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.avatar,
    required this.budget,
    required this.phoneNumber,
  });
  

  UserModel copyWith({
    String? uid,
    String? name,
    String? email,
    String? avatar,
    double? budget,
    String? phoneNumber,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      avatar: avatar ?? this.avatar,
      budget: budget ?? this.budget,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'avatar': avatar,
      'budget': budget,
      'phoneNumber': phoneNumber,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      avatar: map['avatar'] ?? '',
      budget: map['budget']?.toDouble() ?? 0.0,
      phoneNumber: map['phoneNumber'] ?? '',
    );
  }
}
