class UserModel {
  final String uid;
  final String name;
  final String email;
  final String createdAt;

  const UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.createdAt,
  });


  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'],
      name: json['name'],
      email: json['email'],
      createdAt: json['createdAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'createdAt': createdAt,
    };
  }
}
