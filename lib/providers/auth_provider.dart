import 'package:blood_link_admin/models/admin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class AuthenticationProvider extends ChangeNotifier {
  Admin? admin;

  saveAdmin(Admin admin) {
    this.admin = admin;
  }

  clear() {
    admin = null;
  }
}
