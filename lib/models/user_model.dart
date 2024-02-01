class UserModel {
  String uuid;
  String email;
  String name;
  String password;
  String profilePicture;

  UserModel({required this.uuid,
    required this.email,
    required this.name,
    required this.password,
    this.profilePicture="",
  });

      Map<String,dynamic>toJson()=>{
        'uuid':uuid,
        'email':email,
        'name':name,
        'password':password,
        'profilePicture':profilePicture,

      };
}