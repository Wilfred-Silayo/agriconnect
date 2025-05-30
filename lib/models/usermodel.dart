import 'package:flutter/material.dart';

// class UserModel {
//   final String id;
//   final String firstName;
//   final String lastName;
//   final String email;
//   final String phoneNumber;
//   final String userRole;
//   UserModel(
//       {required this.id,
//       required this.firstName,
//       required this.lastName,
//       required this.email,
//       required this.phoneNumber,
//       required this.userRole});
  // UserModel.fromData(Map<String, dynamic> data)
  //     : id = data['id'],
  //       firstName = data['firstName'],
  //       lastName = data['lastName'],
  //       email = data['email'],
  //       phoneNumber = data['phoneNumber'],
  //       userRole = data['userRole'];
  // Map<String, dynamic> toJson() {
  //   return {
  //     'id': id,
  //     'firstName': firstName,
  //     'lastName': lastName,
  //     'email': email,
  //     'phoneNumber': phoneNumber,
  //     'userRole': userRole,
  //   };
  // }
//}

// class UserProvider extends ChangeNotifier {
//   UserModel? _user;

//   UserModel? get user => _user;

//   void setUser(User user) {
//     _user = user as UserModel?;
//     notifyListeners();
//   }
// }