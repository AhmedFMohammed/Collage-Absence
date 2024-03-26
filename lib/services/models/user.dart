import 'dart:convert';

import 'package:flutter/services.dart';

class UserModel {
  String? firstName, lastName, username, phoneNumber, speciality;
  Uint8List? profilePicture;
  UserModel(
      {this.firstName,
      this.lastName,
      this.username,
      this.phoneNumber,
      this.profilePicture,
      this.speciality});

  UserModel.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    username = json['username'];
    phoneNumber = json['phoneNumber'];
    profilePicture = json['image_encoded'];
    speciality = json['speciality'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['username'] = this.username;
    data['phoneNumber'] = this.phoneNumber;
    data['image_encoded'] = this.profilePicture;
    data['speciality'] = this.speciality;
    return data;
  }
}

class ProfileModel {
  String? speciality;
  Uint8List? profilePicture;

  ProfileModel({this.profilePicture, this.speciality});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    profilePicture = base64Decode(json['image_encoded']);
    speciality = json['speciality'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image_encoded'] = this.profilePicture;
    data['speciality'] = this.speciality;
    return data;
  }
}
