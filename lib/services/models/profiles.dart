import 'dart:convert';

import 'package:flutter/foundation.dart';

class Profile {
  int? id;
  String? imageEncoded;
  Uint8List? profilePicture;
  String? speciality;
  int? user;

  Profile(
      {this.id,
      this.imageEncoded,
      this.profilePicture,
      this.speciality,
      this.user});

  Profile.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    imageEncoded = json["image_encoded"];
    profilePicture = base64Decode(json['image_encoded']);
    speciality = json["speciality"];
    user = json["user"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["image_encoded"] = imageEncoded;
    _data["profile_Picture"] = profilePicture;
    _data["speciality"] = speciality;
    _data["user"] = user;
    return _data;
  }
}
