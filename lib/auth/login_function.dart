import 'package:blood_link_admin/Firebase/storage.dart';
import 'package:blood_link_admin/global_comonents/custom_messageHandler.dart';
import 'package:blood_link_admin/main_screens/admin_main_screen.dart';
import 'package:blood_link_admin/models/admin.dart';
import 'package:blood_link_admin/providers/auth_provider.dart';
import 'package:blood_link_admin/settings/print.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginFunction {
  // static BloddBankLogin({
  //   required String email,
  //   required String password,
  //   required GlobalKey<ScaffoldMessengerState> scaffoldKey,
  // }) async {

  // }
  static Login({
    required String email,
    required String password,
    required GlobalKey<ScaffoldMessengerState> scaffoldKey,
    required BuildContext context,
  }) async {
    var authProvider =
        Provider.of<AuthenticationProvider>(context, listen: false);
    try {
      Map<String, dynamic> user = await FirebaseStorageApi.userDoc(
          email: email, password: password, collection: 'Admin');
      if (user.isNotEmpty) {
        Admin admin = Admin.fromMap(user);
        Print(admin.toString());
        if (admin.password == password) {
          MyMessageHandler.showSnackBar(scaffoldKey, "Success");
          authProvider.saveAdmin(admin);
          Navigator.pushNamed(context, AdminMainScreen.id);
        } else {
          MyMessageHandler.showSnackBar(scaffoldKey, "Wrong email or password");
        }
      } else {
        MyMessageHandler.showSnackBar(scaffoldKey, "Wrong email or password");
      }
    } catch (e) {
      Print(e.toString());
      MyMessageHandler.showSnackBar(scaffoldKey, "Check your network");
    }
  }
}
