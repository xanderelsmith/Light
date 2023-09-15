import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class ApiService {
  ApiService();
  static Future<List<ParseObject>> pullUsers() async {
    QueryBuilder<ParseObject> queryPublisher =
        QueryBuilder<ParseObject>(ParseObject('User'));
    final ParseResponse apiResponse = await queryPublisher.query<ParseObject>();

    if (apiResponse.success && apiResponse.results != null) {
      log(apiResponse.results.toString());
      return apiResponse.results as List<ParseObject>;
    } else {
      return [];
    }
  }
// code to push institutions(already done, do not utilize except in dire situations)

  static Future<ParseResponse> doUsersignUp(
      {required String username,
      required String password,
      required String emailadress,
      required File file,
      required TextEditingController controllerSurname,
      required TextEditingController controllerFirstname,
      required TextEditingController controllerSchoolName}) async {
    final user =
        ParseUser(username.trim(), password.trim(), emailadress.trim());

    ParseResponse response = await user.signUp();

    ParseFileBase? parseFile;
    parseFile = ParseFile(file);
    parseFile.save();
    final currentUser = await ApiService.getUser()
      ..set('schoolName', controllerSchoolName.text)
      ..set('surname', controllerSurname.text)
      ..set('firstname', controllerFirstname.text)
      ..set('schoolLogo', parseFile);
    currentUser.save();

    return response;
  }

  static Future<ParseResponse> doUserLogin({
    required String username,
    required String password,
  }) async {
    final user = ParseUser(username.trim(), password.trim(), null);

    ParseResponse response = await user.login();
    return response;
  }

  static Future<ParseUser> getUser() async {
    final currentUser = await ParseUser.currentUser() as ParseUser?;
    return currentUser!;
  }

  ///checks if user has logged in
  static Future<bool> hasUserLogged() async {
    final currentUser = await ParseUser.currentUser() as ParseUser?;
    if (currentUser == null) {
      return false;
    }
    final ParseResponse? parseResponse =
        await ParseUser.getCurrentUserFromServer(currentUser.sessionToken!);

    if (parseResponse?.success == null || !parseResponse!.success) {
      await currentUser.logout();
      return false;
    } else {
      return true;
    }
  }

  static get allUsers async {
    QueryBuilder<ParseObject> queryPublisher =
        QueryBuilder<ParseObject>(ParseObject('Users'));
    final ParseResponse apiResponse = await queryPublisher.query<ParseObject>();

    if (apiResponse.success && apiResponse.results != null) {
      log(apiResponse.results.toString());
      return apiResponse.results as List<ParseObject>;
    } else {
      return [];
    }
  }

  static Future<ParseResponse> doUserLogOut(
      {required String useremail,
      required String password,
      required String username}) async {
    final user = ParseUser(useremail.trim(), password.trim(), username.trim());

    ParseResponse response = await user.logout();
    return response;
  }

  static Future<ParseResponse> dopasswordReset({
    required String useremail,
  }) async {
    final user = ParseUser(null, null, useremail.trim());

    ParseResponse response = await user.requestPasswordReset();
    return response;
  }
}
