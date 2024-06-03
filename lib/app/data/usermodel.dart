class UserModel {
  final String id;
  final String uid;
  final String role;
  final String userName;
  final String email;
  final String password;

  UserModel({
    required this.email,
    required this.id,
    required this.uid,
    required this.role,
    required this.password,
    required this.userName,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'],
      id: json['id'],
      uid: json['uid'],
      role: json['role'],
      password: json['password'],
      userName: json['userName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'id': id,
      'uid': uid,
      'role': role,
      'password': password,
      'userName': userName,
    };
  }
}
