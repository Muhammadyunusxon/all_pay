class UserModel {
  final String? name;
  final String? username;
  final String? password;
  final String? avatar;
  final String? bio;
  final String? birth;
  final String? email;
  final String? gender;
  final String? phone;
  final String? favourite;
  final String? fcmToken;
  final String? docId;

  UserModel(
      {required this.name,
      required this.username,
      required this.password,
      this.avatar,
      this.bio,
      required this.birth,
      required this.email,
      required this.gender,
      required this.phone,
      required this.favourite,
      required this.fcmToken,
      this.docId});

  factory UserModel.fromJson({Map? data,required String docId}) {
    return UserModel(
      name: data?["name"],
      username: data?["username"],
      password: data?["password"],
      avatar: data?["avatar"],
      bio: data?["bio"],
      birth: data?["birth"],
      email: data?["email"],
      gender: data?["gender"],
      phone: data?["phone"],
      favourite: data?["favourite"],
      fcmToken: data?["fcmToken"],
      docId: docId
    );
  }

  toJson() {
    return {
      "name": name,
      "username": username,
      "password": password,
      "avatar": avatar,
      "bio": bio,
      "birth": birth,
      "email": email,
      "gender": gender,
      "phone": phone,
      "favourite": favourite,
      "fcmToken": fcmToken
    };
  }
}
