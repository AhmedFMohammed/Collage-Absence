class TeacherModel {
  int? id;
  String? username;
  String? password;
  String? password2;
  String? email;
  String? firstName;
  String? lastName;
  bool? is_Teacher;

  TeacherModel({
    this.id,
    this.username,
    this.password,
    this.password2,
    this.email,
    this.firstName,
    this.lastName,
    this.is_Teacher,
  });

  TeacherModel.fromJson(Map<String, dynamic> json) {
    if (json["id"] != null) {
      id = json["id"];
    }
    username = json["username"];
    password = json["password"];
    password2 = json["password2"];
    email = json["email"];
    firstName = json["first_name"];
    lastName = json["last_name"];
    if (json["is_Teacher"] != null) {
      is_Teacher = json["is_Teacher"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (id != null) {
      _data["id"] = id;
    }
    _data["username"] = username;
    _data["password"] = password;
    _data["password2"] = password2;
    _data["email"] = email;
    _data["first_name"] = firstName;
    _data["last_name"] = lastName;

    if (is_Teacher != null) {
      _data["is_Teacher"] = is_Teacher;
    }
    return _data;
  }
}
