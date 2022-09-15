class UserModel {
  String userName;
  String userEmail;
  String userImage;
  String userUid;
  UserModel({
    required this.userEmail,
    required this.userImage,
    required this.userName,
    required this.userUid,
  });
}

class UserModelFirestore {
  String address;
  String phone;
  String age;
  UserModelFirestore({
    required this.address,
    required this.phone,
    required this.age,
  });
}
