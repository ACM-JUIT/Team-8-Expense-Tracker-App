
class UserModel {
  final String uid;
  final String name;
  final String email;
  final String avatar;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.avatar,
  });

  UserModel copyWith({
    String? uid,
    String? name,
    String? email,
    String? avatar,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      avatar: avatar ?? this.avatar,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'avatar': avatar,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      avatar: map['avatar'] ?? '',
    );
  }

  @override
  String toString() {
    return 'UserModel(uid: $uid, name: $name, email: $email, avatar: $avatar)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is UserModel &&
      other.uid == uid &&
      other.name == name &&
      other.email == email &&
      other.avatar == avatar;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
      name.hashCode ^
      email.hashCode ^
      avatar.hashCode;
  }
}
